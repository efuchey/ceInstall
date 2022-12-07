#!/bin/sh

# needed otherwise cmake could pick up the system cc
export CC=gcc
export CXX=g++

# extract path to this file
export modules_home=$(dirname "$(realpath "${BASH_SOURCE:-$0}")")
export OSRELEASE=$( "$modules_home"/osrelease.py )

# loading cmake and gcc on jlab cue machines
case "$hostname" in
	ifarm*|jlabl*)
		module load cmake/3.23.2
		module load gcc/9.3.0
		;;
 esac


# if PHYS_HOME environment variable is not set, set it to the current directory
if [ -z "$PHYS_HOME" ]; then
    export PHYS_HOME=$(realpath $modules_home/../..)
fi

module use "${modules_home}"/modulefiles

echo "Modules loaded for PHYS_HOME=$PHYS_HOME. Use 'module avail' to see available modules."
echo

# adds pinstall to path
export PATH="$PATH":"${modules_home}/../pinstall"
