#!/bin/bash

function tab() {
	echo "	"
}

function link_user() {
	while [ -z "$link" ]; do
		tab
		read -p "Please enter link web site : " link
		link=$(echo $link | tr -d [:blank:])
		if [ -n "$link" ]; then
			link="https://"$link
		fi
	done
}

function cut_text() {
	tab
	read -p "Find : " find
	if [ -n "$find" ]; then
		text=$(curl -s $link | grep -in "$find")
	else
		text=$(curl -s $link)
	fi
	tab
	read -p "Show? (y/n) : " show
	if [ "$show" = "y" ]; then
		echo "$text"
	fi
}

while [ "$again" != "exit" ]; do

	link_user
	cut_text
	tab
	read -p "File?(y/n) : " file
	tab
	if [ "$file" = "y" ]; then
		echo $text >find.txt
	fi
	tab
	read -p "Again? or exit : " again
	unset link
	unset text
	unset file
done
