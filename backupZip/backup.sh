#!/bin/sh
#backup - compress java project in a workspace



#  __                  _   _                 
# / _| ___  _ __   ___| |_(_) ___  _ __  ___ 
#| |_ / _ \| '_ \ / __| __| |/ _ \| '_ \/ __|
#|  _| (_) | | | | (__| |_| | (_) | | | \__ \
#|_|  \___/|_| |_|\___|\__|_|\___/|_| |_|___/
# save one project 
saveOneProject() {
	# create the archive name & compress
	archiveName="${dateCompression}_${project}.zip"
	zip -r "$archiveName" "$project"
	echo "   creating archive [$archiveName]"

	# copy the archive in the optional external folder if given by the user ($2)
	if [[ "$exportFolder" != "/TransfertJavaWorkspace" ]]; then
		mkdir -p "$exportFolder/" && cp "$archiveName" "$exportFolder/t$archiveName"
		echo "   copy in [$exportFolder/t$archiveName] sucessfull"
	fi

	# copy int the workspace to get a local backup
	cp "$archiveName" "archives/t$archiveName"
	echo "   copy in [archives/t$archiveName] sucessfull"
}
# get all java project to save (save all matching project from $3 to $x if given else save all)
saveProjectArguments() {
	projectsToSave="$1"
	IFS=";"
	for param in $*; do
		projectsToSave="$projectsToSave\|$param"
	done
	listProjects=`ls | grep "$projectsToSave"`
echo
}




#            _   _                ___                     _       _     _           
#  __ _  ___| |_(_) ___  _ __    / _ \   __   ____ _ _ __(_) __ _| |__ | | ___  ___ 
# / _` |/ __| __| |/ _ \| '_ \   \ _ //\ \ \ / / _` | '__| |/ _` | '_ \| |/ _ \/ __|
#| (_| | (__| |_| | (_) | | | |  /(_>  <  \ V / (_| | |  | | (_| | |_) | |  __/\__ \
# \__,_|\___|\__|_|\___/|_| |_|  \___/\/   \_/ \__,_|_|  |_|\__,_|_.__/|_|\___||___/
# default values
blackListFolders="dependences;.metadata;.sonarlint;backup.sh;archives"
dateCompression=`date +"20%y%m%d"`
SAVEIFS=$IFS
exportFolder="$2/TransfertJavaWorkspace"
BackupWhy="$1"


# default actions
tempParam="$3"
IFS=";"
for param in $*; do
	if [ "$param" != "$1" ] && [ "$param" != "$2" ] && [ "$param" != "$3" ] && [ "$param" != "" ]; then
		tempParam="$tempParam;$param"
	fi
done
saveProjectArguments $tempParam





#               _      
#  ___ ___   __| | ___ 
# / __/ _ \ / _` |/ _ \
#| (_| (_) | (_| |  __/
# \___\___/ \__,_|\___|
# script start
IFS=$(echo -en "\n\b")
echo "projects to save :"
echo "$listProjects"
echo ""
read -p "press enter to continue or ctrl+c to end the script"

for project in $listProjects; do
	doCompression="yes"

	# check if the folder is blacklisted and if not alows the compression
	IFS=";"
	for blackList in $blackListFolders; do
		if [[ "$blackList" == "$project" ]]; then
			doCompression="no"
		fi
	done
	IFS=$(echo -en "\n\b")

	echo ""
	if [[ "$doCompression" == "yes" ]]; then
		# save why the backup is being done  and print informations
		echo "creating archive for [$project]"
		echo "$dateCompression  $BackupWhy" >> "${project}/logs.log"

		saveOneProject
	fi
done
IFS=$SAVEIFS
# script end



echo
echo
echo "backup.sh:V3"
echo "end of script"
