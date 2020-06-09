#!/bin/bash -x

stakePerDay=100
betMoney=1
win=1
loose=0

stake=$stakePerDay
if (($((RANDOM%2))==$win))
then
	stake=$(($stake + $betMoney))
	echo "Won the bet"
else
	stake=$(($stake - $betMoney))
	echo "Lost the bet"
fi
