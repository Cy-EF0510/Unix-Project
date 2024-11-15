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
echo "Network"
}

#Services
Services() {
echo "Services"
}

#User Management
User_Management() {
echo ""
echo -e "\e[1m\e[34m\e[4mUser Management\e[0m"
PS3=$'\nEnter an option [1-9]: '
user_management_menu=("Add a user" "Give root permission to a user" "Delete a user" "Show active users" "Disconnect a use>
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
