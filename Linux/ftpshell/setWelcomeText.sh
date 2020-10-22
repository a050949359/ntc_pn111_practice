#看main.sh
DIA='/usr/bin/dialog'
TMP="/tmp/checklist.$$"

#welcome.txt的位置
W_FILE=/etc/vsftpd/welcome.txt

#welcome.txt先備份一份
TMP_W_FILE=/etc/vsftpd/.welcome.txt

#vsftp設定檔的位置
CONF_FILE=/etc/vsftpd/vsftpd.conf
REPLACE_TEXT=""

#有檔案就改檔名建一個新的，沒有就直接建一個
if [ -f $W_FILE ]; then
  	mv $W_FILE $TMP_W_FILE
	touch $W_FILE
else
	touch $W_FILE
fi

#輸入框
$DIA --title "EDIT BOX" --editbox $TMP_W_FILE 10 40 2> /etc/vsftpd/welcome.txt
if [ $(echo $?) -eq 0 ]; then
	#得到banner_file的行號
	BF_LN=$(cat $CONF_FILE | awk '/banner_file/{print NR}')
	
	#要寫入的參數內容
        XXX="banner_file=$W_FILE"

        if [[ -z "$BF_LN" ]]; then
		#沒找到行號，直接在最後寫入
                sed -i '$a'"$XXX" $CONF_FILE
        else
		#刪掉第$BF_LN行，在最後一行寫入
                sed -i "$BF_LN"'d' $CONF_FILE
                sed -i '$a'"$XXX" $CONF_FILE
        fi

	#顯示成功
	dialog --backtitle "message" --title "success" --msgbox "set success" 10 40
else
	#按取消時把換過檔名的welcome.txt換回來
	rm $W_FILE
        mv $TMP_W_FILE $W_FILE
	dialog --backtitle "message" --title "cancel" --msgbox "cancel" 10 40
fi

#重啟服務
systemctl restart vsftpd
#clear
