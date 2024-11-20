#! /bin/bash

echo "XYX Corp LTD."
echo ""
Main_Menu_Function () {
while true; do 
echo ""
echo -e "\e[1m\e[36m\e[4mM A I N - M E N U\e[0m"
PS3=$'\nEnter an option [1-7]: ' 
options=("System Status" "Backup" "Network" "Services" "User Management" "File Management" "Exit")
select option in "${options[@]}"
do
	case $option in 
		"System Status")
			System_Status
			break
		;;
		"Backup")
			Backup
			break
   		;;
		"Network")
			Network
   			break
		;;
		"Services")
			Services
   			break
		;;
		"User Management")
			User_Management
   			break
		;;
		"File Management")
			File_Management
   			break
		;;
		"Exit")
			echo "Exiting Program..."
			exit 0
		;;
		*)
			echo "Error: Wrong input"
		;;
	esac
 done
done
}

#System Status
System_Status() {
echo ""
echo -e "\e[1m\e[34m\e[4mSYSTEM - STATUS\e[0m"
PS3=$'\nEnter an option [1-6]: '
ssMenu=("Memory Status" "CPU Temperature" "Active Processes" "Stop and Close Process" "Main Menu" "Exit Program")
select option in "${ssMenu[@]}"
do
	case $option in
		"Memory Status")
			echo "Checking Memory Status"
			free
		;;
		"CPU Temperature")
			echo "CPU Temperature (Please note that '86_pkg_temp' is the CPU's temperature)"
			(paste <(cat /sys/class/thermal/thermal_zone*/type) <(cat /sys/class/thermal/thermal_zone*/temp) | column -s $'\t' -t | sed 's/\(.\)..$/.\1°C/') | grep 'x86_pkg_temp'
		;;
		"Active Processes")
			echo "Active Processes"
			echo "Press "q" to exit"
			top
		;;
		"Stop and Close Process")
			echo "Please enter the process you wish to stop and close: "
			read process
			killall $process
			echo "$process has been terminated"
		;;
		"Main Menu")
			echo "Going Back to Main Menu..."
                        echo ""
                        PS3=$'\nEnter your choice [1-7]: '
			break
		;;
 		"Exit Program")
                        echo "Exiting Program..."
                        exit 0
                ;;
		*)
			echo "Error: Wrong input"
		;;
	esac
done
}

#Backup
Backup() {
echo ""
echo -e "\e[1m\e[34m\e[4mBACKUP\e[0m"
PS3=$'\nEnter an option [1-4]: '
backupMenu=("Make a Backup Schedule" "Show Last Backup Process" "Main Menu" "Exit Program")
select option in "${backupMenu[@]}"
do
	case $option in
		"Make a Backup Schedule")
			echo "Please enter a day of the week in which you want to backup a file: "
			read 
		;;
		"Show Last Backup Process")
			echo "CPU Temperature"
		;;
		"Main Menu")
			echo "Going Back to Main Menu..."
			echo ""
			break
		;;
		*)
			echo "Error: Wrong input"
		;;
	esac
done
}

#Network
Network() {
        echo " "
        echo "== NETWORK MENU =="
        echo "1. Show network cards, IP adresses, and default gateways"
        echo "2. Enable/Disable a network card"
        echo "3. Set an IP adress on a network card"
        echo "4. Connect to a nearby wifi network"
        echo "5. Exit to the main menu"
        echo " "

        while true; do
        read -p "Select an option [1-5]: " option

        case $option in
                1)
                echo -e "Network cards and IP adresses: " 
                ip -brief address show
                echo "Default gateways: "
                ip route | grep default
                ;;
                2)
                echo "Here are the available network cards: "
                ip -brief address show
                read -p "Choose a network card: " card
                read -p "Do you want to enable or disable it? (e/d) " ed
                if [ "$ed" == "e" ]; then
                        sudo ip link set "$card" up
                        echo ""$card" enabled."
                elif [ "$ed" == "d" ]; then
                        sudo ip link set "$card" down
                        echo ""$card" disabled."
                else
                        echo "Error: wrong input. Please answer with 'e' or 'd'."
                fi
                ;;
		3)
                echo "Here are the available network cards: " 
                ip -brief address show
                read -p "Select a network card to set the IP adress on: " card
                read -p "Enter an IP address: " ip
                sudo ip addr add "$ip" dev "$card"
                echo "IP address "$ip" has been set on "$card"."
                ;;
                4)
                echo "Here are the available wifi networks: "
                nmcli dev wifi | awk '{print$2}' | tail -n +2
                read -p "What wifi do you want to connect to: " wifi
                read -s -p "Enter the wifi password: " password
                if [ -n "$password" ]; then
                        nmcli dev wifi connect "$wifi" password "$password"
                        echo "Successfully connected to "$wifi"."
                else 
                        nmcli dev wifi connect "$wifi"
                        echo "Successfully connected to "$wifi"."
                fi
                ;;
                5)
                main menu
                ;;
                *)
                echo "Invalid option. Please choose between option 1 to 5."
                ;;
        esac
done
}
Network


#Services
Services() {
	echo " "
        echo "== SERVICES MENU =="
        echo "1. List current services"
        echo "2. Start/Stop a service"
        echo " "

        while true; do
        read -p "Select an option [1-2]: " option

        case $option in
                1)
                echo "Here is a list of the current services: "
                systemctl list-units --type service
                ;;
                2)
                read -p "Choose a service: " serv
                read -p "Do you want to start it or stop it? " action
                if [ "$action" == "start" ]; then
                        systemctl start "$serv"
                        echo "Service "$serv" has been started."
                elif [ "$action" == "stop" ]; then
                        systemctl stop "$serv"
                        echo "Service "$serv" has been stopped."
                else
                        echo "Wrong input. Please answer with 'start' or 'stop'."
                fi
                ;;
                *)
                echo "Invalid option. PLease choose between option 1 and 2."
                ;;
        esac
done
}
Services

#User Management
User_Management() {
echo ""
echo -e "\e[1m\e[34m\e[4mUser Management\e[0m"
PS3=$'\nEnter an option [1-9]: '
user_management_menu=("Add a user" "Give root permission to a user" "Delete a user" "Show active users" "Disconnect a user" "Show the list of all groups that a user is a member of them" "Change the user group" "Main Menu" "Exit Program")
select option in "${user_management_menu[@]}"
do
        case $option in 

        "Add a user")
        echo "Please enter the new username: "
        read new_user
        if id $new_user &>/dev/null; then
                echo "The user already exists. "
                else
                sudo useradd $new_user
                sudo passwd $new_user
                echo "A new user has been added with a password. "
        fi
        ;;
        "Give root permission to a user")
        echo "Please enter a username: "
        read new_sudo_user
        if id $new_sudo_user &>/dev/null; then
                sudo usermod -aG root $new_sudo_user
                echo "The user now has root permission. "
        else
                echo "The user doesn't exist. "
        fi
        ;;
        "Delete a user")
                echo "Please enter a username: "
                read user
                if id $user &>/dev/null; then
                    echo "Are you sure you want to delete the user? (Y/N)"
                    read ans
                        if [[ $ans == [Yy] ]]; then
                                sudo userdel -r $user
                                echo "User succesfully deleted"
                        elif [[ $ans == [Nn] ]]; then
                                echo "The user will not be deleted. "
                        else
                                echo "invalid input"
                fi
                else
                        echo "User doesn't exist. "
        fi
        ;;
        "Show active users")
                who
        ;;

        "Disconnect a user")
                echo "Please enter the user you want to log out: "
                read kill_user
                sudo pkill -KILL -u $kill_user
        ;;
        "Show the list of all groups that a user is a member of them")
                echo "Please enter a username: "
                read user
                        if id $user &>/dev/null; then
                        groups $user
                        else
                        echo "The user doesn't exist. "
                        fi
        ;;
        "Change the user group")
                echo "Not done yet"
        ;;
        "Main Menu")
                echo "Going Back to Main Menu..."
                echo ""
                PS3=$'\nEnter your choice [1-7]: '
                break
        ;;
        "Exit Program")
                echo "Exiting Program..."
                exit 0
        ;;
        *)
                echo "Invalid option"
        ;;
        esac
done

}

#File Management
File_Management() {
echo "File Management"
}

Main_Menu_Function
echo $?
