VboxExtpackAutoinstall
===================
Simple script for automatic installation of VirtualBox Extension Pack.
This is useful if your Linux Distribution doesn't come with Extension Pack installed by default.

# Usage
Just run the script:
```bash
./run.sh
```
It will automatically download correct extension pack version and handle the installation process.

# VirtualBox / Extension Pack version upgrade
If the extension pack stops working due to a version upgrade, just re-run the script:
```bash
./run.sh
```
It will automatically remove old version and fetch the new one.
