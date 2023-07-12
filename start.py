import os
import subprocess

if os.path.exists("/root/.ssh"):
    print("Setting ssh key permissions")
    subprocess.call("chmod 400 -R /root/.ssh", shell=True)

if os.path.exists("/root/.gitconfig"):
    print("Found global gitconfig.")
else:
    print("Warn: Missing global git settings. Mount to /root/.gitconfig")

if os.path.exists("/root/.aws"):
    print("Found global aws settings")
else:
    print("Warn: Missing aws settings. Mount to /root/.aws")

if os.path.exists("/repositories"):
    print("Launching lunarvim with repositories")
else:    
    print("Warn: Missing /repositories. Mount to /repositories")
input("Press Any Key to continue")
