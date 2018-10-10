""" Rule for building Boost from sources. """

load(
    "//tools/build_defs:framework.bzl",
    "CC_EXTERNAL_RULE_ATTRIBUTES",
    "cc_external_rule_impl",
    "create_attrs",
)
load("//tools/build_defs:detect_root.bzl", "detect_root")

BOOST_ATTRIBUTES = dict(CC_EXTERNAL_RULE_ATTRIBUTES)
BOOST_ATTRIBUTES.update({
    # Only build these libraries.
    "boost_libraries": attr.string_list(mandatory = True, default = []),
})

def _boost_build(ctx):
    attrs = create_attrs(
        ctx.attr,
        configure_name = "BuildBoost",
        configure_script = _create_configure_script,
        make_commands = ["./b2 install --prefix=."],
    )
    return cc_external_rule_impl(ctx, attrs)

def _create_configure_script(configureParameters):
    ctx = configureParameters.ctx
    root = detect_root(ctx.attr.lib_source)

    return "\n".join([
        "cd $INSTALLDIR",
        "cp -R $EXT_BUILD_ROOT/{}/. .".format(root),
        "./bootstrap.sh --with-libraries={}".format(",".join(attrs.boost_libraries)),
    ])

""" Rule for building Boost. Invokes bootstrap.sh and then b2 install.
  Attributes:
    boost_srcs - target with the boost sources
"""
boost_build = rule(
    attrs = BOOST_ATTRIBUTES,
    fragments = ["cpp"],
    output_to_genfiles = True,
    implementation = _boost_build,
)
