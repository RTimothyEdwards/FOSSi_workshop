#!/bin/sh
# SPDX-FileCopyrightText: 2021-2022 Harald Pretl
# Johannes Kepler University, Institute for Integrated Circuits
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
# SPDX-License-Identifier: Apache-2.0

# This script was adapted for the Latch-Up workshop from osic-multitools

# Define setup environment
# ------------------------
export SRC_DIR="$HOME/src"

# ---------------
# Now go to work!
# ---------------

# Update Ubuntu installation
# ----------------------------------
sudo apt -qq update -y
sudo apt -qq upgrade -y

# Install all the packages available via apt
# ------------------------------------------
echo ">>>> Installing required (and useful) packages via APT"
sudo apt -qq install -y git python3 python3-pip python3-venv python3-tk \
        build-essential automake autoconf gawk m4 flex bison \
        octave octave-signal octave-communications octave-control \
        xterm csh tcsh htop mc gedit vim vim-gtk3 kdiff3 \
        tcl8.6 tcl8.6-dev tk8.6 tk8.6-dev \
        graphicsmagick ghostscript mesa-common-dev libglu1-mesa-dev \
        libxpm-dev libx11-6 libx11-dev libxrender1 libxrender-dev \
        libxcb1 libx11-xcb-dev libcairo2 libcairo2-dev  \
        libxpm4 libxpm-dev libgtk-3-dev libxaw7-dev libfftw3-dev \
        libreadline-dev libtool

# Add /usr/local/bin to PATH
export PATH="$HOME/.local/bin:$PATH"

# Install volare
pip3 install volare

# Install the PDK
volare enable 42cd15c469adc1d303ffca4a7d32c29a4564a737 --pdk sky130

# Install CACE
pip3 install cace

# Install examples
git clone https://github.com/RTimothyEdwards/sky130_ef_ip__instramp.git "$HOME/sky130_ef_ip__instramp"
git clone https://github.com/RTimothyEdwards/sky130_ef_ip__rdac3v_8bit.git "$HOME/sky130_ef_ip__rdac3v_8bit"
git clone https://github.com/RTimothyEdwards/sky130_ef_ip__xtal_osc_32k.git "$HOME/sky130_ef_ip__xtal_osc_32k"
git clone https://github.com/b-etz/sky130_be_ip__lsxo.git "$HOME/sky130_be_ip__lsxo"

# Install/update xschem
# ---------------------
if [ ! -d "$SRC_DIR/xschem" ]; then
        echo ">>>> Installing xschem"
        sudo apt build-dep -y xschem
        git clone https://github.com/StefanSchippers/xschem.git "$SRC_DIR/xschem"
        cd "$SRC_DIR/xschem" || exit
else
        echo ">>>> Updating xschem"
        cd "$SRC_DIR/xschem" || exit
        git pull
fi
./configure
make -j"$(nproc)" && sudo make install


# Install/update xschem-gaw
# -------------------------
if [ ! -d "$SRC_DIR/xschem-gaw" ]; then
        echo ">>>> Installing gaw"
        git clone https://github.com/StefanSchippers/xschem-gaw.git "$SRC_DIR/xschem-gaw"
        cd "$SRC_DIR/xschem-gaw" || exit
else
        echo ">>>> Updating gaw"
        cd "$SRC_DIR/xschem-gaw" || exit
        git pull
fi
aclocal && automake --add-missing && autoconf
./configure
make -j"$(nproc)" && sudo make install


# Install/update magic
# --------------------
if [ ! -d "$SRC_DIR/magic" ]; then
        echo ">>>> Installing magic"
        git clone https://github.com/RTimothyEdwards/magic.git "$SRC_DIR/magic"
        cd "$SRC_DIR/magic" || exit
        git checkout magic-8.3
else
        echo ">>>> Updating magic"
        cd "$SRC_DIR/magic" || exit
        git pull
fi
./configure
make -j"$(nproc)" && sudo make install


# Install/update netgen
# ---------------------
if [ ! -d "$SRC_DIR/netgen" ]; then
        echo ">>>> Installing netgen"
        git clone https://github.com/RTimothyEdwards/netgen.git "$SRC_DIR/netgen"
        cd "$SRC_DIR/netgen" || exit
        git checkout netgen-1.5
else
        echo ">>>> Updating netgen"
        cd "$SRC_DIR/netgen" || exit
        git pull
fi
./configure
make -j"$(nproc)" && sudo make install


# Install/update ngspice
# ----------------------
if [ ! -d  "$SRC_DIR/ngspice" ]; then
        echo ">>>> Installing ngspice"
        git clone git://git.code.sf.net/p/ngspice/ngspice "$SRC_DIR/ngspice"
        cd "$SRC_DIR/ngspice" || exit
        sudo apt install -y 
else
        echo ">>>> Updating ngspice"
        cd "$SRC_DIR/ngspice" || exit
        git pull
fi
./autogen.sh
./configure
make -j"$(nproc)" && sudo make install

# Finished
# --------
echo ""
echo ">>>> All done!"
