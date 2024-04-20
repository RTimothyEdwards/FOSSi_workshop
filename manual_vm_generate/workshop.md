# Workshop Instructions

These instructions assume you are working on Ubunto 22.04 LTS, but should easily map to other Linux distributions. When in doubt, you can always create a VM based on Ubuntu 22.04 LTS.

## Dependencies

First we need to install some dependencies to manage the Python packages and virtual environments. Tkinter is used for the GUI of CACE and git is used to clone the repositories.

    sudo apt install python3-pip python3-venv python3-tk git

## Install the PDK

We use [volare](https://github.com/efabless/volare) to easily install the sky130 PDK. Volare downloads a pre-built PDK so you don't have to build it yourself. It also has the option to build the PDK locally using [open_pdks](https://github.com/rtimothyedwards/open_pdks).

To keep our packages separated, let's create and enable a virtual environment for Python packages in the current directory:

    python3 -m venv workshop-packages

To activate the virtual environment, run:

    source workshop-packages/bin/activate

Next, install volare using pip:

    pip3 install volare

To list available pre-built PDKs for sky130:

    volare ls-remote --pdk sky130

Finally, enable the sky130 PDK by specifying the hash of the build:

    volare enable 6d4d11780c40b20ee63cc98e645307a9bf2b2ab8 --pdk sky130

Downloading the PDK may take some time depending on your internet connection. The default installation directory for the PDKs, the `PDK_ROOT`, is `~/.volare`.

You have now succesfully installed the PDK.

## Install the Tools needed by CACE

Instead of cloning and compiling each tool yourself, we created a small script based on [osic-multitool](https://github.com/iic-jku/osic-multitool) that will do this for you.

Run the script:

    sh workshop_setup.sh

## Install CACE

[CACE](https://github.com/efabless/cace) can be easily installed via pip. Make sure that your previously created virtual environment is activated and run:

    pip3 install cace

That's it already! You can now either run CACE from the command line using `cace` or start the GUI via `cace-gui`.

To try out CACE, download the example [sky130_ef_ip__instramp](https://github.com/RTimothyEdwards/sky130_ef_ip__instramp):

    git clone https://github.com/RTimothyEdwards/sky130_ef_ip__instramp.git

Enter the directory (`cd sky130_ef_ip__instramp`) and run `cace-gui` from there. A window should open with a list of parameters and you should be able to run them.

Have fun!
