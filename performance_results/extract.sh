#extracting Requests per second from all files
for file in *;do
	awk 'NR==24' file 
done
