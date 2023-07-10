import subprocess
import re
def test_node():
    # v18.16.1
    output = str(subprocess.check_output('node --version', shell=True), encoding='utf8').strip()
    print(output)
    search = re.search(r'v\d+\.\d+\.\d+', output)
    print(search)
    if search:
        major, minor, patch = search.group(0).replace("v","").split(".")
        assert(int(major) >= 18)
        assert(int(minor) >= 16)
        assert(int(patch) >= 0)
    else:
        raise AssertionError("expected match")

