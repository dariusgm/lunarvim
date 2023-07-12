import subprocess
import re
def test_git():

    # git version 2.34.1
    output = str(subprocess.check_output('git --version', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'git\sversion\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 2)
        assert(int(minor) >= 34)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")


def test_make():

    # GNU Make 4.3
    # Built for x86_64-pc-linux-gnu
    # Copyright (C) 1988-2020 Free Software Foundation, Inc.
    # License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
    # This is free software: you are free to change and redistribute it.
    # There is NO WARRANTY, to the extent permitted by law.
    output = str(subprocess.check_output('make --version', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'GNU\sMake\s(\d+\.\d+)', output)
    if search:
        major, minor = search.group(1).split(".")
        assert(int(major) == 4)
        assert(int(minor) >= 3)
    else:
        raise AssertionError(f"expected match: {output}")



def test_gcc():
    
    # gcc (Ubuntu 11.3.0-1ubuntu1~22.04.1) 11.3.0
    # Copyright (C) 2021 Free Software Foundation, Inc.
    # This is free software; see the source for copying conditions.  There is NO
    # warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
    output = str(subprocess.check_output('gcc --version', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'gcc \(.*\)\s(\d+\.\d+.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 11)
        assert(int(minor) >= 3)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")


def test_xsel():
    # xsel version 1.2.0 by Conrad Parker <conrad@vergenet.net>
    output = str(subprocess.check_output('xsel --version', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'xsel\sversion\s(\d+\.\d+\.\d+)', output)
    if search:
        major, minor, patch = search.group(1).split(".")
        assert(int(major) == 1)
        assert(int(minor) >= 2)
        assert(int(patch) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")



def test_unzip():

    # UnZip 6.00 of 20 April 2009, by Debian. Original by Info-ZIP.

    # Usage: unzip [-Z] [-opts[modifiers]] file[.zip] [list] [-x xlist] [-d exdir]
    #   Default action is to extract files in list, except those in xlist, to exdir;
    # ...
    output = str(subprocess.check_output('unzip', shell=True), encoding='utf8').strip().split("\n")[0]
    search = re.search(r'UnZip\s(\d+\.\d+)', output)
    if search:
        major, minor = search.group(1).split(".")
        assert(int(major) == 6)
        assert(int(minor) >= 0)
    else:
        raise AssertionError(f"expected match: {output}")

