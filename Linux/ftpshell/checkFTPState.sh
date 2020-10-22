#取得vsftpd狀態，有Active 的那行，第二個字
FTP_STATE=$(systemctl status vsftpd | grep "Active" |awk '{print $2}')

if [ $FTP_STATE == "active" ]; then
	echo "0"
elif [ $FTP_STATE == "inactive" ]; then
	echo "1"
else
	echo "3"
fi
