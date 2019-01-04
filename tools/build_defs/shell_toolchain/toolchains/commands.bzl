CommandInfo = provider(
    doc = "",
    fields = {
        "arguments": "TODO",
        "doc": "TODO",
    },
)

ArgumentInfo = provider(
    doc = "",
    fields = {
        "name": "",
        "type_": "",
        "doc": "",
    },
)

PLATFORM_COMMANDS = {
    "os_name": CommandInfo(
        arguments = [],
        doc = "Returns OS name",
    ),
    "pwd": CommandInfo(
        arguments = [],
        doc = "Returns command for getting current directory.",
    ),
    "echo": CommandInfo(
        arguments = [ArgumentInfo(name = "text", type_ = type(""), doc = "Text to output")],
        doc = "Outputs 'text' to stdout",
    ),
    "export_var": CommandInfo(
        arguments = [
            ArgumentInfo(name = "name", type_ = type(""), doc = "Variable name"),
            ArgumentInfo(name = "value", type_ = type(""), doc = "Variable value"),
        ],
        doc = "Defines and exports environment variable.",
    ),
    "local_var": CommandInfo(
        arguments = [
            ArgumentInfo(name = "name", type_ = type(""), doc = "Variable name"),
            ArgumentInfo(name = "value", type_ = type(""), doc = "Variable value"),
        ],
        doc = "Defines local shell variable.",
    ),
    "use_var": CommandInfo(
        arguments = [
            ArgumentInfo(name = "name", type_ = type(""), doc = "Variable name"),
        ],
        doc = "Expression to address the variable.",
    ),
    "env": CommandInfo(
        arguments = [],
        doc = "Print all environment variables",
    ),
    "path": CommandInfo(
        arguments = [
            ArgumentInfo(name = "expression", type_ = type(""), doc = "Path"),
        ],
        doc = "Adds passed arguments in the beginning of the PATH.",
    ),
    "touch": CommandInfo(
        arguments = [ArgumentInfo(name = "path", type_ = type(""), doc = "Path to file")],
        doc = "Creates a file",
    ),
    "mkdirs": CommandInfo(
        arguments = [ArgumentInfo(name = "path", type_ = type(""), doc = "Path to directory")],
        doc = "Creates a directory and, if neccesary, it's parents",
    ),
    "tmpdir": CommandInfo(
        doc = "Creates a temp directory",
        arguments = [],
    ),
    "if_else": CommandInfo(
        doc = "Creates if-else construct",
        arguments = [
            ArgumentInfo(name = "condition", type_ = type(""), doc = "Condition text"),
            ArgumentInfo(name = "if_text", type_ = type(""), doc = "If block text"),
            ArgumentInfo(name = "else_text", type_ = type(""), doc = "Else block text"),
        ],
    ),
    "define_function": CommandInfo(
        arguments = [
            ArgumentInfo(name = "name", type_ = type(""), doc = "Function name"),
            ArgumentInfo(name = "text", type_ = type(""), doc = "Function body"),
        ],
        doc = "Defines a function with 'text' as the function body.",
    ),
    "replace_in_files": CommandInfo(
        arguments = [
            ArgumentInfo(name = "dir_", type_ = type(""), doc = "Directory to search recursively"),
            ArgumentInfo(name = "from_", type_ = type(""), doc = "String to be replaced"),
            ArgumentInfo(name = "to_", type_ = type(""), doc = "Replace target"),
        ],
        doc = "Replaces all occurrences of 'from_' to 'to_' recursively in the directory 'dir'.",
    ),
    "copy_dir_contents_to_dir": CommandInfo(
        arguments = [
            ArgumentInfo(
                name = "source",
                type_ = type(""),
                doc = "Source directory, immediate children of which are copied",
            ),
            ArgumentInfo(name = "target", type_ = type(""), doc = "Target directory"),
        ],
        doc = "Copies contents of the directory to target directory",
    ),
    "symlink_contents_to_dir": CommandInfo(
        arguments = [
            ArgumentInfo(
                name = "source",
                type_ = type(""),
                doc = "Source directory, immediate children of which are symlinked, or file to be symlinked.",
            ),
            ArgumentInfo(name = "target", type_ = type(""), doc = "Target directory"),
        ],
        doc = """
Symlink contents of the directory to target directory (create the target directory if needed).
If file is passed, symlink it into the target directory.""",
    ),
    "symlink_to_dir": CommandInfo(
        arguments = [
            ArgumentInfo(
                name = "source",
                type_ = type(""),
                doc = "Source directory",
            ),
            ArgumentInfo(name = "target", type_ = type(""), doc = "Target directory"),
        ],
        doc = """
Symlink all files from source directory to target directory (create the target directory if needed).
NB symlinks from the source directory are copied.""",
    ),
    "script_prelude": CommandInfo(
        arguments = [],
        doc = "Function for setting necessary environment variables for the platform",
    ),
    "increment_pkg_config_path": CommandInfo(
        arguments = [
            ArgumentInfo(
                name = "source",
                type_ = type(""),
                doc = "Source directory",
            ),
        ],
        doc = """Find subdirectory inside a passed directory with *.pc files and add it
    to the PKG_CONFIG_PATH""",
    ),
    "cleanup_function": CommandInfo(
        arguments = [
            ArgumentInfo(name = "message_cleaning", type_ = type(""), doc = "Message to output about cleaning"),
            ArgumentInfo(name = "message_keeping", type_ = type(""), doc = "Message to output about keeping directories"),
        ],
        doc = "Trap function called after the script is finished",
    ),
    "children_to_path": CommandInfo(
        arguments = [
            ArgumentInfo(name = "dir_", type_ = type(""), doc = "Directory"),
        ],
        doc = "Put all immediate subdirectories (and symlinks) into PATH",
    ),
    "define_absolute_paths": CommandInfo(
        arguments = [
            ArgumentInfo(name = "dir_", type_ = type(""), doc = "Directory where to replace"),
            ArgumentInfo(name = "abs_path", type_ = type(""), doc = "Absolute path value"),
        ],
        doc = "Replaces absolute path placeholder inside 'dir_' with a provided value 'abs_path'",
    ),
    "replace_absolute_paths": CommandInfo(
        arguments = [
            ArgumentInfo(name = "dir_", type_ = type(""), doc = "Directory where to replace"),
            ArgumentInfo(name = "abs_path", type_ = type(""), doc = "Absolute path value"),
        ],
        doc = "Replaces absolute path 'abs_path' inside 'dir_' with a placeholder value",
    ),
}