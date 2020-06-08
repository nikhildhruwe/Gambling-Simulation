#!/bin/bash -x

betMoney=1
win=1
loose=0
stakePerDay=100
maxDays=20

for (( day=1;$day<=$maxDays;day++ ))
do
	stake=$stakePerDay
	while (( 1 ))
	do
		if (($((RANDOM%2))==$win))
		then
			stake=$(($stake + $betMoney))
			#echo "Won the bet"
		else
			stake=$(($stake - $betMoney))
			#echo "Lost the bet"
		fi

		if (( $stake==$(($stakePerDay*50/100)) || $stake==$(($stakePerDay +$stakePerDay*50/100)) ))
		then
			#echo "Resigning for the day"
			break;
		fi
	done

	if (( $stake>$stakePerDay))
	then
		difference=$(($stake-$stakePerDay))
		echo "Day $day won by : $difference"
	else
		difference=$(($stakePerDay-$stake))
		echo "Day $day lost by : $difference"
	fi
done

