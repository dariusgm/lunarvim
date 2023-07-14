import subprocess
import re


def test_r():
    # R version 4.1.2 (2021-11-01) -- "Bird Hippie"
    # Copyright (C) 2021 The R Foundation for Statistical Computing
    # Platform: x86_64-pc-linux-gnu (64-bit)

    output = str(
        subprocess.check_output("R --version", shell=True), encoding="utf8"
    ).strip().split("\n")[0]
    search = re.search(r"R\sversion\s(\d+\.\d+\.\d+)", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 4
        assert int(minor) >= 1
        assert int(patch) >= 0
    else:
        raise AssertionError("expected match")


def test_rscript():
    # R scripting front-end version 4.1.2 (2021-11-01)
    output = str(
        subprocess.check_output("Rscript --version 2>&1", shell=True), encoding="utf8"
    ).strip()
    search = re.search(r"(\d+\.\d+\.\d+)", output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert int(major) >= 4
        assert int(minor) >= 1
        assert int(patch) >= 0
    else:
        raise AssertionError(f"expected match {output}")

