monitors=`xrandr --listmonitors`
monitor_num=`echo $monitors | grep Monitors | awk '{printf $2}'`
echo "monitor num: $monitor_num"
idx=`expr $monitor_num - 1`
for i in `seq 0 $idx`
do
	monitor=`echo $monitors | grep ${i}":" | awk '{printf $6}'`
	echo "monitor $i: $monitor"
done
