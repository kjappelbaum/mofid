#!/bin/bash
# Run Systre analysis on a specified file (or the default)
# Cannot call this successfully from Anaconda, so maintain paths separately

DEFAULT_CGD_PATH="Test/topology.cgd"

kernel=$(uname -s)
if [[ $kernel == CYGWIN_NT* ]]
then
	SBU_BIN="C:/Users/Benjamin/Git/mofid/bin/sbu.exe"
	# Settings for Systre
	JAVA_LOC="C:/Program Files/Java/jre1.8.0_102/bin/java"
	GAVROG_LOC="C:/Users/Benjamin/Software/Gavrog-0.6.0/Systre.jar"
elif [[ $kernel == Linux* ]]
then
	SBU_BIN="/home/bbucior/Git/mofid/bin/sbu"
	JAVA_LOC="java"
	GAVROG_LOC="/home/bbucior/Software/Gavrog-0.6.0/Systre.jar"
else
	echo "Error: Unknown platform.  Please specify file paths in Scripts/run_systre.sh" 1>&2
	exit 1
fi

if [[ $# == 0 ]]  # use default arg
then
	"$JAVA_LOC" -Xmx512m -cp "$GAVROG_LOC" org.gavrog.apps.systre.SystreCmdline "$DEFAULT_CGD_PATH"
else
	for cgd in "$@"
	do
		echo "Running $cgd"
		"$JAVA_LOC" -Xmx512m -cp "$GAVROG_LOC" org.gavrog.apps.systre.SystreCmdline "$cgd"
	done
fi