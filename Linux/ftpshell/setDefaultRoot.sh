#看setWelcomeMessage.sh 跟main.sh
CONF_FILE=/etc/vsftpd/vsftpd.conf
TMP="/tmp/checklist.$$"

#取得指令的第一個參數anonymous or localusers 指令看main.sh
REPLACE_TARGET=$1

#單行輸入畫面，輸入路徑
dialog --title "INPUT BOX" \
  --clear  \
  --inputbox "enter $REPLACE_TARGET default path" 16 51 2> $TMP

#如果按取消之類的，會離開
[ $(echo $?) -ne 0 ] && exit 1

#取得輸入的路徑
REPLACE_ROOT=$(cat $TMP)

#判斷是否為空字串，檔案存在，可讀，可寫
if [ -n $REPLACE_ROOT ] && [ -d $REPLACE_ROOT ] && [ -r $REPLACE_ROOT ] && [ -w $REPLACE_ROOT ]; then
	#如果輸入的字串為anonymous 
	#取得行號以及一共找到幾個，幾個沒用到
	if [ $REPLACE_TARGET == "anonymous" ]; then
    		BF_LN=$(cat $CONF_FILE | awk '/anon_root/{print NR}')
    		BF_COUNT=$(cat $CONF_FILE | awk '/anon_root/{print NR}' | wc -l )
    		XXX="anon_root=$REPLACE_ROOT"
	elif [ $REPLACE_TARGET == "localusers" ]; then
    		BF_LN=$(cat $CONF_FILE | awk '/local_root/{print NR}')
    		BF_COUNT=$(cat $CONF_FILE | awk '/local_root/{print NR}' | wc -l )
    		XXX="local_root=$REPLACE_ROOT"
	fi
	
	#同setWelcome.sh用法
	if [ -z "$BF_LN" ]; then
    		sed -i '$a'"$XXX" $CONF_FILE
	else
    		sed -i "$BF_LN"'d' $CONF_FILE
    		sed -i '$a'"$XXX" $CONF_FILE
	fi

	systemctl restart vsftpd

	dialog --backtitle "message" --title "success" --msgbox "success" 10 40
elif [ -z $REPLACE_ROOT ]; then
	dialog --backtitle "message" --title "path error" --msgbox "empty path" 10 40
else
	dialog --backtitle "message" --title "path error" --msgbox "path not exist or permission denied" 10 40
	htpasswd -c .htpasswd aaa
fi
