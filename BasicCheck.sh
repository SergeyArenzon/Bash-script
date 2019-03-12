#!/bin/bash
dir=${1}
cf=${2}
arg=$3
arg2=$4
compile=0;
leak=0;
threat=0;













if [[ -e "$dir/Makefile" ]]; then #check if Makefile exist
      cd $dir 
	make
	if [ -x "$cf" ]; then #check if runnable
	valgrind --leak-check=yes ./$cf >"$dir/test.txt"  #run and creates valgrid output file

	grep -q "All heap blocks were freed -- no leaks are possible" "test.txt" 	#if no leaks output=0 else 1

	if [ $? -eq 0 ]; then #checks if leaked
		leak="PASS"
		else leak="FAIL"
		fi
	rm test.txt #removes test file

	valgrind --tool=helgrind ./$cf >"$dir/test.txt" 2>&1 #run and creates helgrid output file
	grep -q "ERROR SUMMARY: 0 errors from 0 contexts (suppressed: 0 from 0)" "test.txt" 	

	if [ $? -eq 0 ]; then
		thread="PASS"
		else thread="FAIL"
		fi
	rm test.txt #removes test file

		compile="PASS"
	fi
	
else #if no makefile in this dir
compile="FAIL"		
fi

#program output
 printf "Compilation    Memory leaks    Thread race \n   $compile            $leak           $thread\n "





#program exit value
if [ $leak == "PASS" ] && [ $compile == "PASS" ] && [ $thread == "PASS" ]; then
	exit 0
elif [ $leak == "PASS" ] && [ $compile == "PASS" ] && [ $thread == "FAIL" ]; then
	exit 1
elif [ $compile == "PASS" ] && [ $leak == "FAIL" ] && [ $thread == "PASS" ]; then
	exit 2
elif [ $leak == "FAIL" ] && [ $compile == "PASS" ] && [ $thread == "FAIL" ]; then
	exit 4
else exit 7 

fi







		
		 
