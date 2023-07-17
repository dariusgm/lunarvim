import subprocess
import re
import os
def test_lazygit():

    # commit=5149b24ab3dfad3860e2300519c7c583dcc8c9ff, build date=2023-05-03T08:00:22Z, build source=binaryRelease, version=0.38.2, os=linux, arch=amd64, git version=2.34.1
    output = str(subprocess.check_output('lazygit --version', shell=True), encoding='utf8')
    search = re.search(r'version=(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) >= 0)
        assert(int(minor) >= 38)
        assert(int(patch) >= 0)
    else:
        raise AssertionError("expected match")

def test_lazygit_config():
    path = os.path.join("/root", ".config", "lazygit", "config.yml")
    assert os.path.exists(path)
