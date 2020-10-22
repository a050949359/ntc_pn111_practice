#新增.htaccess的檔案
#並把內容打進去
#AuthType Basic
#AuthName "Please input admin password"
#AuthUserFile /var/www/html/test1/private/.htpasswd
#Require valid-user

#這裡直接指定需要輸入密碼的資料夾位置，沒有讓使用者輸入

FILE=/var/www/html/test1/private/.htaccess

if [ -e $FILE ]; then
	echo "file exist"
else
	echo "not exist"
	echo $'AuthType Basic\nAuthName "Please input admin password"\nAuthUserFile /var/www/html/test1/private/.htpasswd\nRequire valid-user\n' > $FILE
fi
