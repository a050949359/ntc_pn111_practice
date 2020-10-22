echo "0" | dialog --gauge "安裝中..." 10 70 0

yum install httpd -y &> /dev/null 
systemctl start httpd 

echo "100" | dialog --gauge "安裝中..." 10 70 0
sleep 1

dialog --backtitle "http install" --title "complete" --msgbox "http installed" 10 40

clear
