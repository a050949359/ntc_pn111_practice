#找設定檔裡是否有<Directory ...> </Directory> 並把行號輸入到text.txt裡
a=$(cat /etc/httpd/conf/httpd.conf | awk '/<Directory "\/var\/www\/html\/test1\/private">/,/<\/Directory>/{print NR}' > text.txt)   

#把text.txt的文字轉陣列
arr=()
while IFS= read -r line; do
   arr+=("$line")
   echo $line
done <text.txt

#一行一行刪掉
if [ ${#arr[@]} -gt 0 ]; then 
	for i in $(seq 1 ${#arr[@]}); do 
		sed -i "${arr[0]}d" /etc/httpd/conf/httpd.conf
	done
fi

#再新增設定
sed -i '$a<Directory "/var/www/html/test1/private">\n    AllowOverride all\n</Directory>' /etc/httpd/conf/httpd.conf
