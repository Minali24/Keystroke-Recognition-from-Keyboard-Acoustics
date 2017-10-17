#!/bin/bash

#sed 's/\(.*\)\/\(.*\).wav/\2_\1.wav/g' < temp_audio/dev.txt > temp_audio/waves.test
#sed 's/\(.*\)\/\(.*\).wav/\2_\1.wav/g' < temp_audio/train.txt > temp_audio/waves.train


cd temp_audio/audio

for y in `ls`; do cd $y;for x in `ls`; do mv $x ${x%.wav}_$y.wav;done;cd ..; done;

for y in `ls`; do cd $y; cp *.wav ../;cd ..; done;

for y in `ls -d */`; do rm -R $y; done;

cd ../..


