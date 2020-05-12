#!/bin/bash
#FIND_INPUT=$(grep $1 .)
#if [$FIND_INPUT == ""]
#then
#	echo "Folder $1 doesn't exist"
#	exit 1
#else
#	echo $FIND_INPUT
#fi

cd $1 && git diff > ../updateScript.diff && cd .. 
DIFF="$(cat updateScript.diff)"

if ["$DIFF" == ""]
then
	echo "Folder $1 is already up to date"
	exit 1
else
	echo "$1 isn't the latest version of this project"	
	echo "Diff were written to updateScript.diff"
fi

echo "Actions :"
echo "1 -> Pull"
echo "2 -> Overwrite"
echo "Your answer : "

read input
if ["$input" == '1']
then
	cd $1 && git pull && cd ..
else
	if [$input == '2']
	then
		mv $1 $1_save
		echo "Save of $1 folder has been created"
		mkdir $1
		cp -r $1_save/\.git $1/\.git
		cd $1 && git pull && cd ..
		echo "Overwritting is finish."
	fi
fi



