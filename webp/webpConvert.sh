#!/bin/sh
# packets needed
#	dwebp
#		sudo apt-get install dwebp
# webpConvert - convert webp in png



#            _   _                ___                     _       _     _           
#  __ _  ___| |_(_) ___  _ __    / _ \   __   ____ _ _ __(_) __ _| |__ | | ___  ___ 
# / _` |/ __| __| |/ _ \| '_ \   \ _ //\ \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#| (_| | (__| |_| | (_) | | | |  /(_>  <  \ V / (_| | |  | | (_| | |_) | |  __/\__ \
# \__,_|\___|\__|_|\___/|_| |_|  \___/\/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
# default actions
ls_meme=`ls $1*.webp`
folder=`pwd`

# defalt values
SAVEIFS=$IFS
nb_webp=0



#               _      
#  ___ ___   __| | ___ 
# / __/ _ \ / _` |/ _ \
#| (_| (_) | (_| |  __/
# \___\___/ \__,_|\___|
# script start
# IFS allows to change the itteration behavior of the for
IFS=$(echo -en "\n\b")

# itterate all files in the folder and convert them
for file_webp in $ls_meme; do
	# create .png name and convert the file
	file_png=`echo $file_webp | sed 's/\.webp/\.png/g'`
	dwebp "$folder/$file_webp" -quiet -o "$folder/$file_png"

	# count the number of files converted, delete the file and print the result to the user
	nb_webp=$(($nb_webp+1))
	rm "$folder/$file_webp"
	echo "    [$nb_webp/$nb_meme] traitement de : $file_webp"
done
# reset IFS values to what it was at the begining
IFS=$SAVEIFS

echo 
echo
echo "$nb_webp webp converted into png"
# script end



echo
echo
echo "webpConvert.sh:V3"
echo "end of script"
