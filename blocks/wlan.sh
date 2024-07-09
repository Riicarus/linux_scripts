function get_bytes {
    default_route=$(ip route | grep default)
    if [[ "$default_route" == "" ]]
    then
        echo "disconneted"
        exit 0
    fi
    interface=$(echo "$default_route" | awk '{print $5}')
    received_bytes=$(cat /sys/class/net/$interface/statistics/rx_bytes)
    transmitted_bytes=$(cat /sys/class/net/$interface/statistics/tx_bytes)
    line=$(echo $received_bytes $transmitted_bytes | awk '{print "received_bytes="$1, "transmitted_bytes="$2}')
    eval $line
    now=$(date +%s%N)
}

function get_velocity {
    value=$1
    old_value=$2
    now=$3
    timediff=$(($now - $old_time))
    velB=$(echo $value $old_value $timediff | awk '{printf "%.0f", 1000000000*($1-$2)/$3}')
    if test "$velB" -gt 1000
    then
	    if test "$(($velB/1024))" -gt 1000
	    then
	    echo $(echo $velB | awk '{printf "%03d", $1/1024/1024}')M/s
        else
	    echo $(echo $velB | awk '{printf "%03d", $1/1024}')K/s
	    fi
    else
        echo $(echo $velB | awk '{printf "%03d", $1}')B/s
    fi
}

get_bytes
old_received_bytes=$received_bytes
old_transmitted_bytes=$transmitted_bytes
old_time=$now

sleep 1s

get_bytes

vel_recv=$(get_velocity $received_bytes $old_received_bytes $now)
vel_trans=$(get_velocity $transmitted_bytes $old_transmitted_bytes $now)

echo "$vel_recv ↓ $vel_trans ↑"
