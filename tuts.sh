

for i in $(seq 1 1 31)
do
    arr[$i]=0
	arr2[$i]=$i
	if  [ "$i" -le 9 ] 
	then
		content=$(curl --request POST 'https://aplikasi.pertanian.go.id/smshargakab/lhk03prov.asp' \
		--data 'selprop=35&selrepo=lhk03prov&seltgl=0'"$i"'&selbul=10&seltah=16' --insecure |grep -Po '<font size="2" face="Arial">\K.*?(?=</font>)' | sed 's/\,//g')
	else 
	  content=$(curl --request POST 'https://aplikasi.pertanian.go.id/smshargakab/lhk03prov.asp' \
		--data 'selprop=35&selrepo=lhk03prov&seltgl='"$i"'&selbul=10&seltah=16' --insecure |grep -Po '<font size="2" face="Arial">\K.*?(?=</font>)' | sed 's/\,//g')
	fi
	
	tot=0
	for word in $content
	do
		if expr "$word" : '-\?[0-9]\+$' >/dev/null
		then
		  tot=$(($tot + $word)) 
		fi		
	done
	
	arr[$i]=$tot
	
	
   
done
for (( i = 1; i <= 31; i++ ))
do
 for (( j = $i+1; j <= 31; j++ ))
 do  
   ival=${arr[$i]}
   jval=${arr[$j]}
   
   if (( ival < jval ));
   then
     arr[$i]=$jval
	 arr[$j]=$ival
	 
	 ival2=${arr2[$i]}
	 arr2[$i]=${arr2[$j]}
	 arr2[$j]=$ival2
   fi
 done
done

for (( i = 1; i <= 31; i++ ))
do
 echo "Tanggal  ${arr2[$i]} . ${arr[$i]} ";
done