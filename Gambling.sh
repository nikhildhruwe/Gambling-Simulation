#!/bin/bash -x

betMoney=1
win=1
loose=0
stakePerDay=100
maxDays=30
totalAmount=0
winCount=0
looseCount=0
for (( day=1;$day<=$maxDays;day++ ))
do
   stake=$stakePerDay
   while (( 1 ))
   do
      if (($((RANDOM%2))==$win))
      then
         stake=$(($stake + $betMoney))
      else
         stake=$(($stake - $betMoney))
      fi

      if (( $stake==$(($stakePerDay*50/100)) || $stake==$(($stakePerDay +$stakePerDay*50/100)) ))
      then

			totalAmount=$(($totalAmount+$stake))
         echo "Day $day : $totalAmount"
			break;
      fi
   done
   if (($stake>$stakePerDay))
   then
		won[$day]=$day
	else
		lost[$day]=$day
   fi
done
echo "total Amount: $totalAmount "
totalStake=$(($stakePerDay*$maxDays))
if (( $totalAmount>$totalStake ))
then
    difference=$(($totalAmount-$totalStake))
    echo "Total Amount won : $difference"
else
    difference=$(($totalStake-$totalAmount))
    echo "Total Amount lost: $difference"
fi

echo "Days won : ${won[@]}"
echo "Days lost: ${lost[@]}"
