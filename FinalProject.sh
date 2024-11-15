#! /bin/bash

echo "XYX Corp LTD."
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
			echo "Memory Status"
   			break
		;;
		"CPU Temperature")
			echo "CPU Temperature"
   			break
		;;
		"Active Processes")
			echo "Active Processes"
   			break
		;;
		"Stop and Close Process")
			echo "Stop and Close Process"
   			break
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
echo "B A C K U P"
PS3="Enter an option [1-4] "
backupMenu=("Make a Backup Schedule" "Show Last Backup Process" "Main Menu")
select option in "${backupMenu[@]}"
do
	case $option in
		"Make a Backup Schedule")
			echo "Memo"
		;;
		"Show Last Backup Process")
			echo "CPU Temperature"
		;;
		"Main Menu")
			echo "Going Back to Main Menu..."
			echo ""
			break
			#Error Here if you go to back to main menu and exit it doesnt work
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
echo "User Management"
}

#File Management
File_Management() {
echo "File Management"
}

Main_Menu_Function
echo $?
