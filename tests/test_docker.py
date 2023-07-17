import subprocess
import re
import os
def test_docker():
    # Docker version 24.0.4, build 3713ee1
    output = str(subprocess.check_output('docker --version', shell=True), encoding='utf8')
    search = re.search(r'(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) >= 24)
        assert(int(minor) >= 0)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match {output}")

