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

Thanks to Leo Moser for preparing this VM for the workshop.  The original repository
is in https://github.com/mole99/latch-up-workshop

## Requirements

To run CACE, it is necessary to have the following bits and pieces:

- The sky130 PDK.  The easiest way to obtain this is through volare, which
  can be installed with "pip" and will install into your home directory
  under the subdirectory ".volare".  See the line in the install script that
  tells volare to load the sky130 PDK.  The PDK contains the primitive
  device models for ngspice simulation, and standard cell libraries with
  netlists of the standard cells, as well as setup files for xschem, magic,
  and netgen.

- ngspice.  This should be downloaded from SourceForge and compiled and installed.

- xschem.  This should be downloaded from github and compiled and installed.

- magic.  This should be downloaded from github and compiled and installed.

- netgen.  This should be downloaded from github and compiled and installed.

- cace.  This can be installed with "pip".

- CACE examples.  These can be downloaded with a git clone from github and do
  not need to be installed.  The four example repositories can be found at the
  end of the setup script.

Whether you use the provided VM or not, you need these applications and libraries.
Once you have the sky130 PDK, you need to set environment variables for PDK_ROOT
and PDK to point to the root of all PDKs and the sky130 PDK name, respectively;
e.g.,
	export PDK_ROOT=$HOME/.volare/pdks
	export PDK=sky130A

This will inform CACE where the PDK is located, although CACE will also try to
find the PDK in various standard locations.


## The Workshop

The purpose of the workshop is to become familiar with CACE through some
example circuits that make use of it.  The examples at hand are an
operational amplifier, a DAC, and a low-frequency crystal oscillators.
In addition, there is another low-frequency crystal oscillator design
that does not use CACE.

## Task 1:  Run CACE on an example.

The first thing to do is just to run CACE (cace-gui) and perform a complete
characterization by clicking on the "Simulate All" button.  The amplifier
is a good test case---its characterization shouldn't take more than a few
minutes to run (depending on the number of processor cores).

Click on "HTML", then go to a browser and take a look at the generated
page.

Now click on "Settings" and select "Keep simulation files".  Run a single
simulation set on one electrical parameter.  Look in the "ngspice"
directory after the simulations.  What files are there?  How do those
netlists differ from the template netlist?

What other files got created on the fly by CACE?

## Task 2:  Alter a parameter.

Click on the "Pass" button in the "Status" column to see the table of
results.  This is more fun if the simulation doesn't pass.  How would
you tighten up one of the specs to make it fail?  Go change one of
the parameters to make it fail and re-run.  You can do this by making
a copy of the parameter and then editing it to change the spec limit.
After running, did it fail?  What does the table view of the result
look like?

Change the first electrical parameter to run all corners (by editing
the characterization file):  voltage, temperature, and process.  How
many simulations get run?

Now find the offset error parameter and change it to enumerate over all
five corners (sf and fs in addition to ff, ss, and tt).  Again, how many
corners will be run?

What happens if you add a condition that doesn't exist in the testbench?
What happens if you remove a condition that *does* exist in the
testbench?

## Task 3:  Run a Monte Carlo simulation

Look at the Monte Carlo simulation in the RDAC example.  Note how it
uses corner set to "mc" and adds a condition "iterations', and adds
a line "collate: iterations" to the "simulate {}" block.  Does the
testbench define iterations?  If so, where, and what does it do?

Copy an electrical parameter from the amplifier and modify it to
run a Monte Carlo simulation.  Did it work?  If not, why?

Bonus:  Run a mismatch simulation.  Hint:  This is like a Monte
Carlo simulation, except that there are corners named "tt_mm",
"ff_mm", and "ss_mm".

## Task 4:  Repurpose a characterization file.

Get the characterization file from sky130_be_ip__lsxo.  Run it to make
sure it works (warning:  bug in CACE requires "display" to be added to
"DRC_errors" in the phyical parameters).  Run at least one parameter
simulation to check that it works (running all of them may take a long
time).

Copy the whole "cace" directory over to sky130_ef_ip__xtal_osc_32k.
Will it run as-is?  Why or why not?  What needs to be changed to make
the file run correctly?

Once the file is running in CACE, how does this circuit compare (just
look at one electrical parameter result)?
