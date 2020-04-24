#!/bin/sh
# wurl - download pictures from the wurl_url.txt file



#            _   _                ___                     _       _     _           
#  __ _  ___| |_(_) ___  _ __    / _ \   __   ____ _ _ __(_) __ _| |__ | | ___  ___ 
# / _` |/ __| __| |/ _ \| '_ \   \ _ //\ \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#| (_| | (__| |_| | (_) | | | |  /(_>  <  \ V / (_| | |  | | (_| | |_) | |  __/\__ \
# \__,_|\___|\__|_|\___/|_| |_|  \___/\/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
# actions par defaut
listeurl=`cat wurl_url.txt`
mkdir -p download



#               _      
#  ___ ___   __| | ___ 
# / __/ _ \ / _` |/ _ \
#| (_| (_) | (_| |  __/
# \___\___/ \__,_|\___|
# script start
cd download
for url in $listeurl; do
	wget $url
done
# script end



echo
echo
echo "wurl.sh:V2"
echo "end of script"
