import subprocess
import re


def test_bashdb_version():
    # bashdb, release 5.0-1.1.2
    output = str(
        subprocess.check_output("/usr/bin/bashdb --version 2>&1", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"(\d+\..*\.\d+\.\d+)", output)
    if search:
        version1, _version2, version3, version4  = search.group(1).split(".")
        assert int(version1) >= 5
        assert int(version3) >= 0
        assert int(version4) >= 0
    else:
        raise AssertionError(f"expected match {output}")

def test_bashdb_path():
    # /usr/bin/bashdb
    output = str(
        subprocess.check_output("which bashdb", shell=True), encoding="utf8"
    ).strip()
    assert output == '/usr/bin/bashdb'
