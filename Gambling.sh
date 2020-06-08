#!/bin/bash -x

stake=100
betMoney=1
win=1
loose=0

if (($((RANDOM%2))==$win))
then
	money=$(($stake + $betMoney))
	echo "Won the bet"
else
	money=$(($stake - $betMoney))
	echo "Lost the bet"
fi
