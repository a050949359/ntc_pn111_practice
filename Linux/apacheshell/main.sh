#看FTP的main.sh
DIA='/usr/bin/dialog'
TMP="/tmp/checklist.$$"
DIR=$(dirname $0)

FTPSTATE=$("$DIR"/checkHttpState.sh)
echo $FTPSTATE

#1.網頁需要輸入帳密 ，2.建立virtual host
$DIA --clear --nocancel  --backtitle "Linux Shell Script Tutorial" \
     --title "HTTP" \
     --menu "setup menu" 11 50 4 \
     1 "Set .htaccess" \
     2 "Add virtual host" \
     3 "exit" 2>$TMP

FSTYPE=$(cat $TMP)
echo $?
while [[ $FSTYPE -ne 3 ]]
do
	if [[ $FSTYPE -eq 1 ]]; then
		#這裡一步做到完，沒有讓使用者輸入或選擇的地方
		 
	
	#virtual host
	elif [ $FSTYPE == "2" ]; then
		$DIR/setVirtualHost.sh
			
	fi

	$DIA --clear --nocancel  --backtitle "Linux Shell Script Tutorial" \
		--title "HTTP" \
     		--menu "setup menu" 11 50 4 \
     		1 "Set .htaccess" \
     		2 "Add virtual host" \
     		3 "exit" 2>$TMP
	FSTYPE=$(cat $TMP)  
done

clear
