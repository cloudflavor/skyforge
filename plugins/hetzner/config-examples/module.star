module(
    name = "hetzner",
    version = "v0.1.0",
    description = """
    This is a sample docstring for the skyforge module that
    will manipulate resources on Hetzner.
    This output can be shown when running skycrane
    """,
    environments = [
        Environment(
            name = "staging",
            labels_suffix = "-stg",
            path = "stg",
        ),
        Environment(
            name = "production",
            path = "prd",
        ),
    ],
)
