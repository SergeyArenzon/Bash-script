#!/bin/bash
dir=${1}
cf=${2}
compile=0;
leak=0;

if [[ -e "$dir/Makefile" ]]; then
      cd $dir 
	if [ -x "$cf" ]; then
	valgrind  --error-exitcode=1 ./$cf
	leak=$?
	
	if [ $leak -eq 1 ]; then
	leak="Pass"
	else leak="Fail"
	fi
	valgrind --tool=helgrind ./$cf
	echo $?
	compile="Pass"
	fi
	
else
	compile="Fail"
			

fi


		
		 
