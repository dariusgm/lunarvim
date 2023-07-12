import subprocess
import re
def test_aws():
    # aws-cli/2.7.30 Python/3.9.11 Linux/5.19.0-46-generic exe/x86_64.ubuntu.22 prompt/off
    output = str(subprocess.check_output('aws --version', shell=True), encoding='utf8').strip()
    search = re.search(r'aws-cli/(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) >= 2)
        assert(int(minor) >= 7)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match {output}")

