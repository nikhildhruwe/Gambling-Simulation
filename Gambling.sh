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
		Day[$day]=won
		echo "Day $day won by : $difference"
	else
		difference=$(($stakePerDay-$stake))
		Day[$day]=loose

		echo "Day $day lost by : $difference"
	fi
done

#echo ${Day[@]}

count=1
luckyTemp=0
unluckyTemp=0
while (($count<=$maxDays))
do
	####  finding Lucky Day
	if [[ "${Day[$count]}" == "won" ]]
	then
		luckyCount=0
		for ((i=$count;$i<=$maxDays;i++))
		do
			if [[ "${Day[$i]}" == "won" ]]
			then
				((luckyCount++))
			else
				break
			fi
		done

		if (( $luckyCount>$luckyTemp ))
		then
			luckyTemp=$luckyCount
			luckyDay=$(($i-1))
		fi
	fi

	#####  finding unlucky Day
	if [[ "${Day[$count]}" == "loose" ]]
   then
      unluckyCount=0
      for ((j=$count;$j<=$maxDays;j++))
      do
         if [[ "${Day[$j]}" == "loose" ]]
         then
            ((unluckyCount++))
         else
            break
         fi
      done

      if (( $unluckyCount>$unluckyTemp ))
      then
         unluckyTemp=$unluckyCount
         unluckyDay=$(($j-1))
      fi
   fi

((count++))
done

echo "most lucky day was  : $luckyDay"
echo "most unlucky day was: $unluckyDay"
