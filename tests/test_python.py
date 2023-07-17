import subprocess
import re


def test_python():
    # Python 3.11.1
    output = str(
        subprocess.check_output("python --version", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"(\d+\.\d+\.\d+)", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 3
        assert int(minor) >= 11
        assert int(patch) >= 0
    else:
        raise AssertionError(f"expected match {output}")


def test_pip():
    # pip 23.1.2 from /home/darius/.pyenv/versions/3.11.1/lib/python3.11/site-packages/pip (python 3.11)
    output = str(
        subprocess.check_output("pip --version", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"pip\s(\d+\.\d+\.\d+)\s", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 23
        assert int(minor) >= 0
        assert int(patch) >= 0
    else:
        raise AssertionError(f"expected match {output}")


def test_pip_packages():
    output = str(
        subprocess.check_output("pip freeze", shell=True), encoding="utf8"
    ).strip()
    packages = {
        'ansible-lint': '6.17.2',
        'black': '23.3.0',
        'debugpy': '1.6.7',
        'flake8': '6.0.0',
        'gitlint': '0.19.1',
        'pynvim': '0.4.3',
        'pytest': '7.4.0',
        'yamlfix': '1.11.1',
        'yamllint': '1.23.0' 
    }
    for line in output.split("\n"):
        for package, version in packages.items():
            if package in line:
                match = re.search(r"(\d+\.\d+\.\d+)", line)
                if match:
                    major, minor, patch = match.group(1).split(".")
                    major_expected, minor_expected, _patch_expected = version.split(".")
                    assert int(major) == int(major_expected)
                    assert int(minor) >= int(minor_expected)
                    assert int(patch) >= 0
