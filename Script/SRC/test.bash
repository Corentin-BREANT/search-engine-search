#!/bin/bash
echo "Hello world"

fonctiondetest(){
   echo $1
   echo $2
}

addition(){
   sum=$(($1+$2))
   return $sum
}
read -p "Entrez un numéro : " int1
read -p "Entrez un numéro : " int2
add $int1 $int2
echo "Le résultat est : " $?

isvalid=true
count=1
while [ $isvalid ]
do
echo $count
if [ $count -eq 5 ];
then
break
fi
((count++))
done
