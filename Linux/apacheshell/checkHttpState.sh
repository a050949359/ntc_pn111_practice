#同ＦＴＰ的確認狀態
HTTPD_STATE=$(systemctl status httpd | grep "Active" |awk '{print $2}')

if [ $HTTPD_STATE == "active" ]; then
        echo "0"
elif [ $HTTPD_STATE == "inactive" ]; then
        systemctl start httpd
	echo "1"
else
	systemctl start httpd
        echo "2"
fi
