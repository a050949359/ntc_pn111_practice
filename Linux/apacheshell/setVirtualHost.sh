#設定一些路徑以及字串
DOMAIN_NAME=".ddns.net"
CONF_DIR="/etc/httpd/conf.d/"
CONF_EXTENSION=".conf"
SERVER_NAME_P="    ServerName    "
SERVER_ALIAS_P="    ServerAlias   "
DOCUMENT_ROOT_P="    DocumentRoot  "

#幾個暫存檔的位置
TMP="/tmp/checklist.$$"
NAME_TMP="/tmp/namelist.$$"
ROOT_TMP="/tmp/rootlist.$$"
CHECK_TMP="/tmp/checklist.$$"

#輸入你的Domain name不要加.ddns.net
dialog --nocancel --clear --title "Input your name" --inputbox "Please input your name:" 10 30 2> $NAME_TMP
V_HOST_NAME=$(cat $NAME_TMP)

#列出/var/www/html底下的所有資料夾....這六行是我花最久時間找到的
let i=0 # define counting variable
W=() # define working array
while read -r line; do # process file by file
    let i=$i+1
    W+=($i "$line")
done < <( ls -ld /var/www/html/*/ )

#讓使用者選擇domain name要對應的資料夾
ROOT_SELECT=$(dialog --nocancel --title "List file of directory /home" --menu "Chose one" 24 80 17 "${W[@]}" 3>&2 2>&1 1>&3) # show dialog and store output

#  根據選擇取得資料夾路徑
if [ $? -eq 0 ]; then # Exit with OK
    DOCUMENT_ROOT=$(ls -d1 /var/www/html/*/ | sed -n "`echo "$ROOT_SELECT p" | sed 's/ //'`")
fi

#確認完整domain name 以及資料夾位置
CHECK_M="Server name is "$V_HOST_NAME$DOMAIN_NAME$'\n'"Document root at "$DOCUMENT_ROOT
dialog --title "yes/no" --no-shadow --yesno "$CHECK_M" 10 50

#產生Virtual Host的設定檔，檔名為一開始輸入的字串＋.conf
response=$?
if [ $response -eq 0 ]; then
	FILE=$CONF_DIR$V_HOST_NAME$CONF_EXTENSION
	rm -f $FILE
	touch $FILE
	echo '<VirtualHost *:80>' >> $FILE
	echo "$SERVER_NAME_P$V_HOST_NAME$DOMAIN_NAME" >> $FILE
	echo "$SERVER_ALIAS_P$V_HOST_NAME$DOMAIN_NAME" >> $FILE
	echo "$DOCUMENT_ROOT_P$DOCUMENT_ROOT" >> $FILE
	echo '</VirtualHost>' >> $FILE
	dialog --title "success" --msgbox "Conf file create success" 10 40
else
	dialog --title "Fail" --msgbox "Cancel" 5 20
fi

systemctl restart httpd &> /dev/null
