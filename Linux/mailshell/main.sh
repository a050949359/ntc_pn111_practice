#流程如下（如果FTP 跟APACHE 看得懂這個應該也ＯＫ）
#從/home底下找所有使用者名稱
#讓使用者指定要自動備份的帳號
#把always_bcc = 帳號名@Domain Name 寫入conf

CONF_FILE="/etc/postfix/main.cf"
HOST_NAME=$(cat $CONF_FILE | grep "myhostname = " |awk -F' = ' '{print $2}')
$(ls -l /home |grep ^d | awk '{print $9}' > text.txt)

USER_LIST=()
let i=1
USER_LIST+=($i "root")
while IFS= read -r line; do
	let i=$i+1
   	USER_LIST+=($i "$line")
done < text.txt

response=1
while [ $response != 0 ]
do

	SELECT=$(dialog --nocancel --title "選擇要自動備份的帳號" --menu "選一個" 24 80 17 "${USER_LIST[@]}" 3>&2 2>&1 1>&3)
	
	dialog --title "確認" --no-shadow --yesno "選擇 ${USER_LIST[$SELECT*2-1]}@$HOST_NAME 為自動備份帳號?" 10 50

	response=$?
	if [ $response -eq 0 ]; then
		BCC_LN=$(cat $CONF_FILE | awk '/always_bcc = /{print NR}')
       		XXX="always_bcc = ${USER_LIST[$SELECT*2-1]}@$HOST_NAME"

        	if [[ -z "$BCC_LN" ]]; then
               		sed -i '$a'"$XXX" $CONF_FILE
        	else
               		sed -i "$BCC_LN"'d' $CONF_FILE
               		sed -i '$a'"$XXX" $CONF_FILE
        	fi

        	dialog --backtitle "message" --title "完成" --msgbox "設定成功" 10 40
	fi
done

