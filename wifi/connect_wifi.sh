# nmcli device wifi connect wifiname password wifipassword

wifiname=$1
wifipass=$2

nmcli device wifi connect $wifiname password $wifipass

if [[ $? -ne 0 ]]
then echo "Fail to connect to wifi \"$wifiname\", please make sure your wifi is up or check your wifi's name or password"
else echo "Connect to wifi \"$wifiname\""
fi