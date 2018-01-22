import os

# The folder containing files.
filname='httpd'
time_limit='30'
directory = "../../build/"+filname+'/'+time_limit

# Get all files.
list = os.listdir(directory)

# Loop and add files to list.
pairs = []
for file in list:

    # Use join to get full file path.
    location = os.path.join(directory, file)

    # Get size and add to list of tuples.
    size = os.path.getsize(location)
    a={size: file}
    pairs.append(a)

# Sort list of tuples by the first element, size.
pairs.sort()
counter=0
list_names_all_files=[]
list_names=[]
# for pair in pairs:
for item in pairs:
	list_names_all_files.append(pairs[counter].values()[0])
	if counter < 4:
		list_names.append(pairs[counter].values()[0])
	counter+=1
print list_names_all_files
print list_names

for list in list_names_all_files:
	if list not in list_names:
		os.remove(list)

