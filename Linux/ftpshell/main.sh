#ftp 設定參數的主程式

DIA='/usr/bin/dialog'     # 介面指令的位置
TMP="/tmp/checklist.$$"   # 一個暫存檔，＄＄= PID
DIR=$(dirname $0)	  # 取得檔案路徑

#進度條
counter=0		
(
#用ＸＸＸ夾住可修改畫面中的文字
echo "XXX"
echo "Active FTP server"
echo "XXX"

#確認ＦＴＰ有起動
FTPSTATE=$("$DIR"/checkFTPState.sh)
counter=25
echo $counter

#為了讓進度條的畫面看得到
sleep 1

echo "XXX"
echo "check SELinux's FTP setting "
echo "XXX"

#開啟SELinux 對FTP 的設定
./openFTPFirewall.sh
counter=100
echo $counter
sleep 0.5
) |
dialog --title "FTP" --gauge "Please wait" 7 70 0

#選單，選擇後的數字會存入＄ＴＭＰ檔案裡
$DIA --clear --nocancel  --backtitle "Linux Shell Script Tutorial" \
     --title "FTP Parameter" \
     --menu "setup menu" 15 50 4 \
     1 "Welcome massage" \
     2 "Anonymous default root" \
     3 "Local users default root"\
     4 "exit" 2>$TMP

#取得選的數字
FSTYPE=$(cat $TMP)

#使選完之後可以繼續選
while [[ $FSTYPE -ne 4 ]]
do
	if [[ $FSTYPE -eq 1 ]]; then
		#設定歡迎信息
		"$DIR"/setWelcomeText.sh
	elif [ $FSTYPE == "2" ]; then
		#設定匿名的預設路徑
		"$DIR"/setDefaultRoot.sh anonymous
	elif [ $FSTYPE == "3" ]; then
		#設定有帳號使用者的預設路徑
		"$DIR"/setDefaultRoot.sh localusers
	fi

	#選單畫面
	$DIA --clear --nocancel --backtitle "Linux Shell Script Tutorial" \
	--title "FTP Parameter" \
	--menu "setup menu" 15 50 4 \
	1 "Welcome massage" \
	2 "Anonymous default root" \
     	3 "Local users default root"\
     	4 "exit" 2>$TMP

	FSTYPE=$(cat $TMP)  
done

#結束，清除畫面
clear
