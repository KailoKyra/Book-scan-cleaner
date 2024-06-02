#!/bin/bash

i=0
coverWidth=0
coverHeight=0
currentImageWidth=0
currentImageHeight=0
mkdir $1_processed
for filename in $1/*.png; do
	echo currentFilename=$filename 
		if [ "$i" -eq "0" ]; then
			coverWidth=$(magick identify -format '%w' "$filename")
			coverHeight=$(magick identify -format '%h' "$filename")
			echo cover coverWidth=$coverWidth
			echo cover coverHeight=$coverHeight
		fi

		if [ "$i" -gt "0" ]; then
			currentImageWidth=$(magick identify -format '%w' "$filename")
			currentImageHeight=$(magick identify -format '%h' "$filename")
			echo currentImageWidth=$currentImageWidth
			echo currentImageHeight=$currentImageHeight

			widthDiff=0
			heightDiff=0
			((widthDiff=coverWidth-currentImageWidth))
			((heightDiff=coverHeight-currentImageHeight))
			if [ "$widthDiff" -lt "0" ]; then
				widthDiff=0;
			fi
			if [ "$heightDiff" -lt "0" ]; then
				heightDiff=0;
			fi
			echo widthDiff=$widthDiff heightDiff=$heightDiff
				magick "$filename" -splice "$widthDiff"x"$heightDiff" -background white $1_processed/"$(basename -- "$filename")"
				#-crop "$coverWidth"x"$coverHeight"
		fi
	((i=i+1))
done