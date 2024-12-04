#! /bin/bash

#colors
BLACK=$(echo -e "\033[30m")
RED=$(echo -e "\033[91m")
GREEN=$(echo -e "\033[92m")
ORANGE=$(echo -e "\033[33m")
BLUE=$(echo -e "\033[94m")
PINK=$(echo -e "\033[35m")
YELLOW=$(echo -e "\033[93m")
CYAN=$(echo -e "\033[36m")
BRIGHT_MAGENTA=$(echo -e "\033[95m")
WHITE=$(echo -e "\033[37m")
NC=$(echo -e "\033[0;39m")

#effects
Bold=$(echo -e "\033[1m")
Underline=$(echo -e "\033[4m")

#Background
WHITE_BG=$(echo -e "\033[47m")

figlet "XYX Corp LTD ."

Main_Menu_Function () {

echo ""

        echo "${CYAN}========================================================${NC}"
        echo "${BRIGHT_MAGENTA}${Bold}                   == M A I N  M E N U ==                  ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) System Status"
        echo "2) Backup"
        echo "3) Network"
        echo "4) Services"
        echo "5) User Management"
        echo "6) File Management"
        echo "7) Exit the program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

while true; do
read -p "${GREEN}Enter an option [1-7]: ${NC}" option

	case $option in 
		1)
			System_Status
			break
		;;
		2)
			Backup
			break
   		;;
		3)
			Network
   			break
		;;
		4)
			Services
   			break
		;;
		5)
			User_Management
   			break
		;;
		6)
			File_Management
   			break
		;;
		7)
			echo "${RED}Exiting Program...${NC}"
			exit 0
		;;
		*)
			echo "${RED}Error: Wrong input${NC}"
		;;
	esac
done
}

#System Status
System_Status() {
echo ""
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}              == System Status Menu ==                  ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) Memory Status"
        echo "2) CPU Temperature"
        echo "3) Active Processes"
        echo "4) Stop and Close Process"
        echo "5) Main Menu"
        echo "6) Exit the program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

while true; do
read -p "${PINK}Enter an option [1-6]: ${NC}" option
        case $option in

                1)
                        echo "Checking Memory Status"
                        free
                ;;
                2)
                        echo "${GREEN}The temperature is: ${NC}"
                        cpuTemp=$(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/' | awk '{print $2}')
                        if [ ${cpuTemp%.*} -gt 80 ]; then
                                echo "${RED}$cpuTemp${NC}"
                        else
                                echo "${GREEN}$cpuTemp${NC}"
                        fi
                ;;
                3)
                        echo "${GREEN}Active Processes: ${NC}"
                        echo "Press 'q' to exit"
                        top
                ;;
                4)
                        echo ""
                        echo "${GREEN}Active Processes: ${NC}"
                        top -b -n 1 | awk 'NR>=8 && NR<=20 {print $12}' | head -n 10
                        read -p "Please enter the name of the process you wish to stop and close: " process
                        killall $process
                        echo "${GREEN}$process has been terminated${NC}"
                ;;
                5)
                        echo "Going Back to Main Menu..."
                        Main_Menu_Function
                        break
                ;;
                6)
                        echo "${RED}Exiting Program...${NC}"
                        exit 0
                ;;
                *)
                        echo "${RED}Error: Wrong input${NC}"
                ;;
        esac
done
}

#Backup
Backup() {
echo ""
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}                   == BACKUP MENU  ==                   ${NC}"
        echo "${CYAN}========================================================${NC}"
echo "${YELLOW}1) Make a Backup Schedule"
        echo "2) Show Last Backup Process"
        echo "3) Main Menu"
        echo "4) Exit Program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

while true; do
read -p "${PINK}Enter an option [1-4]: ${NC}" option

        case $option in

		1)
			read -p "Please enter the file name in which you wish to backup: " filename
                        if [ -e ./$filename ]; then
                                read -p "Please enter what Day of The Week (1-7) you wish to backup your file (Enter * if you do not wish to input anything): " DayofWeek
                                read -p "Please enter what Month (1-12) you wish to backup your file (Enter * if you do not wish to input anything): " Month
                                read -p "Please enter what Day of The Month (1-31) you wish to backup your file (Enter * if you do not wish to input anything): " DayofMonth
                                read -p "Please enter what Hour (0-23) you wish to backup your file (Enter * if you do not wish to input anything): " Hour
                                read -p "Please enter what Minute (0-59) you wish to backup your file (Enter * if you do not wish to input anything): " Minute
                                backupfile="$filename.bak"
                                if [ ! -d ./BackupDirectory ]; then
                                        mkdir ./BackupDirectory
                                fi
                                #echo "$Minute $Hour $DayofMonth $Month $DayofWeek cp ./$filename ./BackupDirectory/$backupfile" > ./crontab.txt
                                #echo "$Minute $Hour $DayofMonth $Month $DayofWeek touch ./plusplus" > ./crontab.txt
                                
				cron_command="$Minute $Hour $DayofMonth $Month $DayofWeek cp ./$filename ./BackupDirectory/$backupfile"
    				echo "$cron_command" > ./crontab.txt
				crontab ./crontab.txt
                                echo "${GREEN}Succesfully made a backup for $filename${NC}"
                        else
                                echo "${RED}Error: File does not exist${NC}" 
                        fi
		;;
		2)
			if [ -e ./BackupDirectory ]; then
                                echo "Showing Last Backup Process"
                                ls -lt ./BackupDirectory | head -n 2
                        else
                                echo "You have not made any backup files yet."
                        fi


		;;
		3)
			echo "Going Back to Main Menu..."
			Main_Menu_Function
			break
		;;
		4)
			echo "${RED}Exiting Program...${NC}"
			exit 0
                ;;
		*)
			echo "${RED}Error: Wrong input${NC}"
		;;
	esac
done
}

#Network
Network() {
        echo " "
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}                   == NETWORK MENU ==                   ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) Show network cards, IP adresses, and default gateways"
        echo "2) Enable/Disable a network card"
        echo "3) Set an IP adress on a network card"
        echo "4) Connect to a nearby wifi network"
        echo "5) Exit to the main menu"
        echo "6) Exit the program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

        while true; do
        echo " "
        read -p "${PINK}Select an option [1-6]: ${NC}" option

        case $option in
                1)
                echo "Network cards and IP adresses: " 
                ip -brief address show
                echo "Default gateways: "
                ip route | grep default
                ;;
                2)
                echo "Here are the available network cards: "
                ip -brief address show
                read -p "Choose a network card: " card
                if ip link show "$card" &>/dev/null; then
                        read -p "Do you want to enable or disable it?[e/d]: " ed
                        if [ "$ed" == "e" ]; then
                                sudo ip link set "$card" up
                                echo ""$card" enabled."
                        elif [ "$ed" == "d" ]; then
                                sudo ip link set "$card" down
                                echo ""$card" disabled."
                        else
                                echo "${RED}Error: wrong input. Please answer with 'e' or 'd'.${NC}"
                        fi
                else
                        echo "${RED}Error. The network card "$card" does not exist.${NC}"
                fi
                ;;
		3)
                echo "Here are the available network cards: " 
                ip -brief address show
                read -p "Select a network card to set the IP adress on: " card
                if ip link show "$card" &>/dev/null; then
                        read -p "Enter an IP address: " ip
                        if ping -c 1 -W 1 "$ip" &>/dev/null; then
                                sudo ip addr add "$ip" dev "$card"
                                echo "IP address "$ip" has been set on "$card"."
                        else
                                echo "${RED}Error. IP adress "$ip" does not exist.${NC}"
                        fi
                else
                        echo "${RED}Error. The network card "$card" does not exist.${NC}"
                fi
                ;;
                4)
                if (! dpkg -l | grep -E '^ii' | grep network-manager &>/dev/null); then
                        echo "Please install network-manager with command 'sudo apt-get install network-manager' to see the network options. "
                else
                        sudo systemctl start NetworkManager
                        echo "${ORANGE}Please wait to see the available networks. ${NC}"
                        nmcli dev wifi | awk '{print$2}' | tail -n +2
                fi
                read -p "${GREEN}What wifi do you want to connect to: ${NC}" wifi
                if nmcli dev wifi list | awk '{print $2}' | grep -wq "$wifi"; then
                        read -s -p "${GREEN}Enter the Wi-Fi password: ${NC}" password
                        echo ""
                        echo "${ORANGE}Please wait a couple seconds for the Wi-Fi to connect. ${NC}"
                        echo ""
                        if nmcli dev wifi connect "$wifi" password "$password" &>/dev/null; then
                                echo "${GREEN}Successfully connected to $wifi.${NC}"
                        else
                                echo "${RED}Failed to connect. Please check your password and try again.${NC}"
                        fi
                else
                        echo "${RED}The Wi-Fi network '$wifi' is not available. Please check the SSID and try again. ${NC}"
                fi
		;;
                5)
		echo "Going Back to Main Menu..."
		Main_Menu_Function
                break
                ;;
                6)
                echo "${RED}Exiting the program...${NC}"
                exit 0
                ;;
                *)
                echo "${RED}Invalid option. Please choose between option 1 to 6.${NC}"
                ;;
        esac
done
}

#Services
Services() {
        echo " "
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}                  == SERVICES MENU ==                   ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) Look at the current services"
        echo "2) Start/Stop a service"
        echo "3) Exit to the main menu"
        echo "4) Exit the program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

        while true; do
        read -p "${PINK}Select an option [1-4]: ${NC}" option

        case $option in
                1)
                echo "Here is a list of the current services: "
                echo "Press 'q' to exit"
                echo ""
                systemctl list-units --type service
                ;;
                2)
		echo "Available services: "
                echo "Press 'q' to exit"
                echo ""
                systemctl list-units --type service
                read -p "Choose a service: " serv
                if systemctl status $serv &>/dev/null; then
                        read -p "Do you want to start it or stop it? " action
                        if [ "$action" == "start" ]; then
                                systemctl start "$serv"
                                echo "${GREEN}Service "$serv" has been started.${NC}"
                        elif [ "$action" == "stop" ]; then
                                systemctl stop "$serv"
                                echo "${GREEN}Service "$serv" has been stopped.${NC}"
                        else
                                echo "${RED}Wrong input. Please answer with 'start' or 'stop'.${NC}"
                        fi
                else
                        echo "${RED}The service '$serv' doesn't exist. ${NC}"
                fi
                ;;
                3)
                echo "Going Back to Main Menu..."
		Main_Menu_Function
                break
                ;;
                4)
                echo "${RED}Exiting the program...${NC}"
                exit 0
                ;;
                *)
                echo "${RED}Invalid option. PLease choose between option 1 and 4.${NC}"
                ;;
        esac
done
}

#User Management
User_Management() {
echo " "
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}              == USER MANAGEMENT MENU ==                ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) Add a user"
        echo "2) Give root permission to a user"
        echo "3) Delete a user"
        echo "4) Show active users"
        echo "5) Disconnect a user"
        echo "6) List of all groups of a user"
        echo "7) Change the user group"
        echo "8) Main Menu"
        echo "9) Exit Program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

        while true; do
        read -p "${PINK}Select an option [1-9]: ${NC}" option

        case $option in
        1)
        read -p "Please enter the new username: " new_user
        if id $new_user &>/dev/null; then
                echo "${RED}The user already exists. ${NC}"
        else
                sudo useradd $new_user
                sudo passwd $new_user
                echo "${GREEN}A new user has been added with a password. ${NC}"
        fi
        ;;
        2)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd
        read -p "Please enter a username: " new_sudo_user
        if id $new_sudo_user &>/dev/null; then
                sudo usermod -aG root $new_sudo_user
                echo "${GREEN}The user '$new_sudo_user' now has root permission. ${NC}"
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        3)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id $user &>/dev/null; then
            read -p "Are you sure you want to delete the user? (Y/N): " ans
                if [[ $ans == [Yy] ]]; then
                        sudo userdel -r $user
                        echo "${GREEN}User succesfully deleted${NC}"
                elif [[ $ans == [Nn] ]]; then
                        echo "${GREEN}The user will not be deleted. ${NC}"
                else
                        echo "${RED}invalid input${NC}"
                fi
        else
                echo "${RED}User doesn't exist. ${NC}"
        fi
        ;;
        4)
        who
        ;;
        5)
	echo "${GREEN}List of logged in users: ${NC}"
        who | awk {'print $1'}
        read -p "Please enter the user you want to log out: " kill_user
	if id $kill_user &>/dev/null; then
        	if who | grep -w $kill_user &>/dev/null; then
                	sudo pkill -KILL -u $kill_user
                	echo "${GREEN}$kill_user disconnected.${NC}"
        	else
                	echo "${RED}User already disconnected. ${NC}"
		 fi
	else
 		echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        6)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id $user &>/dev/null; then
		echo "${GREEN}Here are the groups that $user is a part of: ${NC}"
                groups $user
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        7)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id $user &>/dev/null; then
                read -p "Please enter the new group: " newGroup
                if grep -q $newGroup /etc/group &>/dev/null; then
                        sudo usermod -aG $newGroup $user
                        echo "${GREEN}$user has been added to the group $newGroup. ${NC}"
                else
                        echo "${RED}The group doesn't exist. ${NC}"
                fi
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        8)
        echo "Going Back to Main Menu..."
	Main_Menu_Function
        break
        ;;
        9)
        echo "${RED}Exiting Program...${NC}"
        exit 0
        ;;
        *)
        echo "${RED}Invalid option${NC}"
        ;;
        esac
done
}

#File Management
File_Management() {
echo " "
        echo "${CYAN}========================================================${NC}"
        echo "${BLACK}${WHITE_BG}              == FILE MANAGEMENT MENU ==                ${NC}"
        echo "${CYAN}========================================================${NC}"
        echo "${YELLOW}1) Path to a file in user's home directory"
        echo "2) 10 largest files in the user's home directory"
        echo "3) 10 oldest files in the user's home directory"
        echo "4) Send a file as an email attachment"
        echo "5) Main Menu"
        echo "6) Exit Program${NC}"
        echo "${CYAN}========================================================${NC}"
        echo " "

        while true; do
        read -p "${PINK}Select an option [1-6]: ${NC}" option

        case $option in
        1)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id $user &>/dev/null; then
                read -p "Please enter an existing file: " file
                home_dir=$(eval echo "~$user")
                file_path="$home_dir/$file"
                if [ -f "$file_path" ]; then
                        echo "${GREEN}File found: $file_path${NC}"
                else
                        echo "${RED}The file doesn't exist in the home directory of $user. ${NC}"
                fi
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        2)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id $user &>/dev/null; then
                home_dir=$(eval echo "~$user")
                if [ -d "$home_dir" ]; then
                echo "${GREEN}10 largest files in $home_dir:${NC}"
                echo ""
                find "$home_dir" -type f -exec du -h {} + 2>/dev/null | sort -rh | head -n 10
                else
                        echo "${RED}The home directory for user '$user' does not exist.${NC}"
                fi
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
        3)
	echo "${GREEN}Available users: ${NC}"
        cut -d: -f1 /etc/passwd	
        read -p "Please enter a username: " user
        if id "$user" &>/dev/null; then
                home_dir=$(eval echo "~$user")
                if [ -d "$home_dir" ]; then
                        echo "${GREEN}10 largest files in $home_dir:${NC}"
                        echo ""
                        find "$home_dir" -type f -printf "%T+ %p\n" 2>/dev/null | sort | head -n 10
                else
                        echo "${RED}The home directory for user '$user' does not exist.${NC}"
                fi
        else
                echo "${RED}The user doesn't exist. ${NC}"
        fi
        ;;
	4)
        read -p "Enter the recipient's email address: " email
        read -p "Enter the full path of the file to attach: " file
        if [ ! -f "$file" ]; then
                echo "${RED}The file '$file' doesn't exist.${NC}"
        fi
        read -p "Enter the subject of the email: " subject
        read -p "Enter the message body: " body
	echo "${ORANGE}Please wait for confirmation that the email has sent. (This could take up to 2 minutes)${NC}"
        if command -v mail &>/dev/null; then
                echo "$body" | mail -s "$subject" -A "$file" "$email"
                echo "${GREEN}Email sent successfully to $email with file attachment.${NC}"
        else
                echo "The 'mail' command is not installed. Please install it by running the command 'sudo apt-get install mailutils' and try again."

        fi
        ;;
        5)
        echo "Going Back to Main Menu..."
        Main_Menu_Function
        break
        ;;
        6)
        echo "${RED}Exiting Program...${NC}"
        exit 0
        ;;
        *)
        echo "${RED}Invalid option${NC}"
        ;;
        esac
done
}

Main_Menu_Function
echo $?
