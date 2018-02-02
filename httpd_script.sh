#!/bin/bash
application_name=$1
time_limit=$2
bitcode_dir=/home/ehtasham/autotuning-extras/bitcode
executable_dir=/home/ehtasham/autotuning-extras/executables
application_dir=/home/ehtasham
if [ $application_name == "httpd" ]
	then 
	bitcode_dir=$bitcode_dir/httpd
	executable_dir=$executable_dir/httpd
	application_dir=$application_dir/httpd
		if [ $time_limit -eq 10800 ]
			then
			bitcode_dir=$bitcode_dir/10800
			executable_dir=$executable_dir/10800
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
			for executable in $executable_dir/*;do
				cp $executable $application_dir/$application_name
				cd $application_dir
				sudo ./configure
				sudo make
				sudo make install
				cd /home/ehtasham/autotuning-extras/ab_results
				ab -k -c 1000 -n 500000 http://127.0.0.1/:80> $counter
				((counter++))



			done
		elif [ $time_limit -eq 7200 ]
			then 
			bitcode_dir=$bitcode_dir/7200
		elif [ $time_limit -eq 3600 ]
			then 
			bitcode_dir=$bitcode_dir/3600
		else
			echo "please enter correct time limit"
		fi
else
	echo "please enter correct application_name"
fi
# cd ~/autotuning-extras
