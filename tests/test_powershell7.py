import subprocess
import re
def test_powershell7():

    # PowerShell 7.3.5
    output = str(subprocess.check_output('pwsh --version', shell=True), encoding='utf8').strip()
    print(output)
    search = re.search(r'PowerShell\s(\d+\.\d+\.\d+)', output)
    print(search)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) >= 7)
        assert(int(minor) >= 3)
        assert(int(patch) >= 0)
    else:
        raise AssertionError("expected match")

