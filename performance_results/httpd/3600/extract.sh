#extracting Requests per second from all files
for file in *;do
	awk 'NR==24' $file > Requests_per_second/$file.txt
	# echo $file
done
