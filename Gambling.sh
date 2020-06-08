#!/bin/bash -x

betMoney=1
win=1
stakePerDay=100
maxDays=30
totalAmount=0
while ((1))
do
echo "       Gambler Details for the month"
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
         break;
      fi
   done

   if (( $stake>$stakePerDay))
   then
      won[$day]=$day
      Day[$day]=won
   else
      lost[$day]=$day
      Day[$day]=lost
   fi
done

echo "total Amount at month end: $totalAmount "
totalStake=$(($stakePerDay*$maxDays))
if (( $totalAmount>$totalStake ))
then
    difference=$(($totalAmount-$totalStake))
    echo "Amount won : $difference"
else
    difference=$(($totalStake-$totalAmount))
    echo "Amount lost: $difference"
fi
echo "Days won : ${won[@]}"
echo "Days lost: ${lost[@]}"

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
   if [[ "${Day[$count]}" == "lost" ]]
   then
      unluckyCount=0
      for ((j=$count;$j<=$maxDays;j++))
      do
         if [[ "${Day[$j]}" == "lost" ]]
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
echo " "
while ((1))
do
	echo "select 1 or 2"
	echo "1.Continue playing next month."
	echo "2.Stop playing "
	read choice
	if (($choice==1 || $choice==2  ))
	then
		break
	else
		echo "Invalid choice. Select again"
	fi
done

if (( $choice == 2))
then
	echo "player opted to stop."
	break
else
	echo "player wants to continue"
fi
done
