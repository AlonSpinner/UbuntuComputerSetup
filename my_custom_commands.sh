#!/bin/bash

# opens nautilus in current directory
function nautilushere() {
	nautilus "$pwd"	
}

# if in a linked folder, this will send the terminal to the real path
function link2real() {
	cd "$(pwd -P)" #"" aknowledges that some paths have spaces in them
}

# sync onedrive, if connection times out - sync again
function onedrivesync() {
	n=${1:-5} #n takes the first value, or 5 if none is provided

	echo "starting to sync with $n attempts"
	while [ $n -gt 0 ]
	do
		result=$(onedrive --synchronize >$(tty))  #>$(tty) prints command's outputs to terminal 'as it goes'
		if [ -z "$result" ] ; then
			echo "finished syncing"	
			return 0 #sucess
		else #process returned non zero
			echo "starting another sync, n = $n"			
			((n--))
		fi
	done
	echo 'finished all iterations without sucess'
}

# we usualy use cmake 3.10 for ROS reasons, but sometimes we want to move to a 3.22 version placed in a local install.
# calling this function will do the trick (assuming you have it installed
# view article "install cmake version 3.22 WITHOUT REMOVING THE DEFAULT 3.10" in UbuntuComputerSetup
function cmaketo322() {
	export PATH=$HOME/LocalInstalls/cmake-install/bin:$PATH
	export CMAKE_PREFIX_PATH=$HOME/LocalInstalls/cmake-install:$CMAKE_PREFIX_PATH 
	echo "running cmake --version:"
	echo $(cmake --version)
}

function condade() {
	conda deactivate
	conda deactivate
}

function activatevenv(){
	source .venv/bin/activate
}


