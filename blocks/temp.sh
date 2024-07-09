cores=`cat /proc/cpuinfo | grep "cpu cores" | uniq | awk '{printf $4}'`
core_temps=`sensors | grep Core`
max=0
for ((i=0; i<8; i++))
do
temp=`echo $core_temps | grep "Core $i:" | awk '{printf substr($3, 2, 4)}'`
if [[ $max < $temp ]]; then max=$temp; fi
done

echo "$max°C"