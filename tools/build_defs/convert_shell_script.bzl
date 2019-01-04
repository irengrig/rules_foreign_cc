load("//tools/build_defs/shell_toolchain/toolchains:access.bzl", "call_shell")
load("//tools/build_defs/shell_toolchain/toolchains:commands.bzl", "PLATFORM_COMMANDS")

def convert_shell_script(script_prelude, script, shell_context):
    # 0. split in lines merged fragments
    new_script_prelude = []
    for fragment in script_prelude:
        new_script_prelude += fragment.splitlines()

    new_script = []
    for fragment in script:
        new_script += fragment.splitlines()

    script_prelude = new_script_prelude
    script = new_script

    # 1. replace all variable references
    script_prelude = [replace_var_ref(line, shell_context) for line in script_prelude]
    script = [replace_var_ref(line, shell_context) for line in script]

    # 2. call the functions or replace export statements
    script_prelude = [do_function_call(line, shell_context) for line in script_prelude]
    script = [do_function_call(line, shell_context) for line in script]

    # 3. when functions are calling other functions, which are not defined yet
    [do_function_call(line, shell_context) for line in script_prelude]
    [do_function_call(line, shell_context) for line in script]

    result = "\n".join(script_prelude + shell_context.prelude.values() + script)

    return result

def replace_var_ref(text, shell_context):
    parts = []
    current = text

    # long enough
    for i in range(1, 100):
        (before, separator, after) = current.partition("$$")
        if not separator or not after:
            parts.append(current)
            break
        (varname, separator2, after2) = after.partition("$$")
        if not separator2:
            fail("Variable names are not marked correctly in fragment: {}".format(current))

        parts.append(before)
        parts.append(shell_context.shell.use_var(varname))
        current = after2

    return "".join(parts)

def replace_exports(text, shell_context):
    text = text.strip(" ")
    (varname, separator, value) = text.partition("=")
    if not separator:
        fail("Wrong export declaration")

    (funname, after) = get_function_name(value.strip(" "))

    if funname:
        value = call_shell(shell_context, funname, split_arguments(after.strip(" ")))

    return call_shell(shell_context, "export_var", varname, value)

def get_function_name(text):
    (funname, separator, after) = text.partition(" ")

    if funname == "export" or PLATFORM_COMMANDS.get(funname):
        return (funname, after)
    return (None, None)

def do_function_call(text, shell_context):
    (funname, after) = get_function_name(text)
    if not funname:
        return text

    if funname == "export":
        return replace_exports(after, shell_context)

    arguments = split_arguments(after.strip(" ")) if after else []
    return call_shell(shell_context, funname, arguments)

def split_arguments(text):
    parts = []
    current = text.strip(" ")

    # long enough
    for i in range(1, 100):
        if not current:
            break

        # we are ignoring escaped quotes
        (before, separator, after) = current.partition("\"")
        if not separator:
            parts += current.split(" ")
            break
        (quoted, separator2, after2) = after.partition("\"")
        if not separator2:
            fail("Incorrect quoting in fragment: {}".format(current))

        if before:
            parts += before.strip(" ").split(" ")
        parts.append(quoted)
        current = after2

    return parts