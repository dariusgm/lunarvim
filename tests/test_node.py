import subprocess
import re


def test_node():
    # v18.16.1
    output = str(
        subprocess.check_output("node --version", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"v(\d+\.\d+\.\d+)", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 18
        assert int(minor) >= 16
        assert int(patch) >= 0
    else:
        raise AssertionError("expected match")


def test_npm():
    # 9.5.1
    output = str(
        subprocess.check_output("npm --version", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"(\d+\.\d+\.\d+)", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 9
        assert int(minor) >= 5
        assert int(patch) >= 0
    else:
        raise AssertionError("expected match")


def test_npm_packages():
    # /usr/lib
    # ├── aws-cdk@2.87.0
    # ├── corepack@0.17.0
    # ├── neovim@4.10.1
    # ├── npm@9.5.1
    # ├── tree-sitter-bash@0.19.0
    # ├── tree-sitter-cli@0.20.8
    # ├── tree-sitter-css@0.19.0
    # ├── tree-sitter-dockerfile@0.1.0
    # ├── tree-sitter-hcl@0.2.0-snapshot
    # ├── tree-sitter-html@0.19.0
    # ├── tree-sitter-javascript@0.19.0
    # ├── tree-sitter-json@0.20.0
    # ├── tree-sitter-powershell@0.1.0
    # ├── tree-sitter-python@0.20.1
    # ├── tree-sitter-regex@0.19.0
    # ├── tree-sitter-rust@0.20.3
    # ├── tree-sitter-toml@0.5.1
    # └── tree-sitter-yaml@0.5.0
    output = str(
        subprocess.check_output("npm -g ls", shell=True), encoding="utf8"
    ).strip()
    packages = {
        "aws-cdk": "2.87.0",
        "corepack": "0.17.0",
        "neovim": "4.10.1",
        "npm": "9.5.1",
        "tree-sitter-bash": "0.19.0",
        "tree-sitter-cli": "0.20.8",
        "tree-sitter-css": "0.19.0",
        "tree-sitter-dockerfile": "0.1.0",
        "tree-sitter-hcl": "0.2.0",
        "tree-sitter-html": "0.19.0",
        "tree-sitter-javascript": "0.19.0",
        "tree-sitter-json": "0.20.0",
        "tree-sitter-powershell": "0.1.0",
        "tree-sitter-python": "0.20.1",
        "tree-sitter-regex": "0.19.0",
        "tree-sitter-rust": "0.20.3",
        "tree-sitter-toml": "0.5.1",
        "tree-sitter-yaml": "0.5.0",
    }
    for line in output.split("\n"):
        for package, version in packages.items():
            if package in line:
                match = re.search(r"(\d+\.\d+\.\d+)", line)
                if match:
                    major, minor, patch = match.group(1).split(".")
                    major_expected, minor_expected, patch_expected = version.split(".")
                    assert int(major) == int(major_expected)
                    assert int(minor) >= int(minor_expected)
                    assert int(patch) >= int(patch_expected)
