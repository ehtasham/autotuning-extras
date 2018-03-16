#!/bin/bash
application_name=$1
time_limit=$2

bitcode_dir=/home/ehtasham/autotuning-extras/bitcode/$application_name/$time_limit
executable_dir=/home/ehtasham/autotuning-extras/executables/$application_name/$time_limit
cd $bitcode_dir
for bitcode in *;do
	executable=$(echo $bitcode | cut -d'.' -f 1)
	if [ ! -e $executable_dir/$executable ]; then
		echo "inside if"
		echo $bitcode
		echo $executable_dir/$executable
		sudo clang-3.8 $bitcode -o $executable_dir/$executable -lapr-1 -laprutil-1 -lpcre -lcrypt -ldl -lpthread -luuid -lexpat
	else 
		echo "inside else"
		continue
	fi
done