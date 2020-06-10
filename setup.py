from setuptools import setup

import distutils.command.build_py
import sys
from setuptools.command.install import install
import subprocess
from setuptools import setup, find_packages, Command


class CustomInstall(install):
    def run(self):

        make_command = ["make", "init"]
        print("running make")
        if subprocess.call(make_command, cwd="Python") != 0:
            sys.exit(-1)
        #     set_paths_command = ["python", "set_paths.py"]
        #     print("setting paths")
        #     if subprocess.call(set_paths_command) != 0:
        #         sys.exit(-1)
        super().run()


setup(
    name="mofid",
    description="A system for rapid identification and analysis of metal-organic frameworks",
    author="Benjamin J. Bucior",
    url="https://github.com/snurr-group/mofid",
    version="1.0.1",
    packages=["mofid",],
    package_dir={"mofid": "Python"},
    package_data={
        "mofid": [
            "openbabel/*",
            "openbabel/**/*",
            "Resources/*",
            "Resources/**/*",
            "bin/*",
        ]
    },
    zip_safe=False,
    license="GNU",
    install_requires=['subprocess32>="3.5.0"'],
    cmdclass={"install": CustomInstall},
)
