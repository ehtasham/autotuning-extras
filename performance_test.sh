#!/bin/bash
application_name=$1
time_limit=$2
bitcode_dir=/home/ehtasham/autotuning-extras/bitcode/$application_name/$time_limit
executable_dir=/home/ehtasham/autotuning-extras/executables/$application_name/$time_limit
application_dir=/home/ehtasham/$application_name	
results_dir=/home/ehtasham/autotuning-extras/performance_results/$application_name/$time_limit

cd $bitcode_dir
for bitcode in *;do
	executable=$(echo $bitcode | cut -d'.' -f 1)
	if [ ! -e $executable_dir/$executable ]; then
		sudo clang-3.8 $bitcode -o $executable_dir/$executable -lapr-1 -laprutil-1 -lpcre -lcrypt -ldl -lpthread -luuid -lexpat
	else 
		continue
	fi
done
cd $executable_dir
counter=1
for executable in $executable_dir/*; do
	sudo cp $executable $application_dir/$application_name
	cd $application_dir
	sudo make install
	cd $results_dir
	result=$(basename $executable)
	ab -k -c 1000 -n 500000 http://127.0.0.1/:80 >	 $result
done
		
cd ~/autotuning-extras
