#這裏.htpasswd直接指定位置，為了配合.htaccess內指定的路徑
FILE=/var/www/html/test1/private/.htpasswd
NAME_TMP="/tmp/namelist.$$"
PASSWD_TMP="/tmp/pdlist.$$"

if [ -e $FILE ]; then
        echo "file exist"
else
	#沒有找到.htpasswd檔，讓使用者輸入帳號密碼	
	dialog --nocancel --clear --backtitle ".htpasswd not exist" --title "We need create the new user" --inputbox "Input new user name:" 10 30 2> $NAME_TMP
	UN=$(cat $NAME_TMP)
	dialog --nocancel --clear --title "User's password" --inputbox "Input new user password" 10 30 2> $PASSWD_TMP
        PD=$(cat $PASSWD_TMP)

	#用指令生成.htpasswd
        htpasswd -cb $FILE $UN $PD
fi

