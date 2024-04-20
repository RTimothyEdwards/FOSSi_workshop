# Latch-Up Workshop VM

This repository contains the necessary files to build the VM for the Latch-Up Workshop about [CACE](https://github.com/efabless/cace).

It is gratefully based on [analog-virtualbox-vm-sky130a ](https://github.com/TinyTapeout/analog-virtualbox-vm-sky130a) from Tiny Tapeout.

The VM is based on Ubuntu 22.04 and installs the tools needed for CACE using `workshop_setup.sh`.

Details for the VM:

- Username: latchup
- Password: latchup

To download the VM, go to the ["Actions"](https://github.com/mole99/latch-up-workshop-vm/actions) tab of this repository. Click on the latest successful run (green checkmark) and download 
`latch-up-workshop-vm.ova` from the "Artifacts" section.

## Troubleshooting

In case of issues with the graphics (e.g. texts do not appear inside Xschem), try disabling 3D acceleration by opening the VM settings in Virtual Box, going to the "Display" tab, and unchecking "Enable 3D Acceleration" at the bottom of the window.

## Acknowledgement

Thanks to Leo Moser for preparing this VM for the workshop.  The original repository is in https://github.com/mole99/latch-up-workshop
