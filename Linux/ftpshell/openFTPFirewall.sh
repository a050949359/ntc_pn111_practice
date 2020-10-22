#取得SELinux對ftp相關設定，抓ftp_full_access的設定
FTP_FA=$(getsebool -a |grep "ftpd_full_access" |awk '{print $3}')

if [ $FTP_FA == "off" ]; then
	#打開
	setsebool -P ftpd_full_access 1
fi

#跟上面一樣
FTP_HD=$(getsebool -a |grep "tftp_home_dir" |awk '{print $3}')

if [ $FTP_HD == "off" ]; then
        #打開
	setsebool -P tftp_home_dir 1
fi
