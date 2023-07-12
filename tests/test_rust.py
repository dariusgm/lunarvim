import subprocess
import re
def test_cargo():
    # cargo 1.70.0 (ec8a8a0ca 2023-04-25)
    output = str(subprocess.check_output('cargo --version', shell=True), encoding='utf8').strip()
    search = re.search(r'cargo\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 1)
        assert(int(minor) >= 70)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")

def test_rustc():
    # rustc 1.70.0 (90c541806 2023-05-31)
    output = str(subprocess.check_output('rustc --version', shell=True), encoding='utf8').strip()
    search = re.search(r'rustc\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 1)
        assert(int(minor) >= 70)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match {output}")

def test_rigpreg():
    # ripgrep 13.0.0
    # -SIMD -AVX (compiled)
    # +SIMD -AVX (runtime)
    output = str(subprocess.check_output('rg --version', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'ripgrep\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 13)
        assert(int(minor) >= 0)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")

def test_code_minimap():
    # code-minimap 0.6.4
    output = str(subprocess.check_output('code-minimap --version', shell=True), encoding='utf8').strip()
    search = re.search(r'code-minimap\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 0)
        assert(int(minor) >= 6)
        assert(int(patch) >= 0)
    else:
        raise AssertionError("expected match")

