#! /bin/bash

echo "XYX Corp LTD."
echo ""
Main_Menu_Function () {
echo "M A I N - M E N U"
PS3="Enter your choice [1-7] "
options=("System Status" "Backup" "Network" "Services" "User Management" "File Management" "Exit")
select option in "${options[@]}"
do
	case $option in 
		"System Status")
			System_Status
			PS3="Enter your choice [1-7] "
			echo "M A I N - M E N U"
			echo "1) System Status"
			echo "2) Backup"
			echo "3) Network"
			echo "4) Services"
			echo "5) User Management"
			echo "6) File Management"
			echo "7) Exit"

		;;
		"Backup")
			Backup
			PS3="Enter your choice [1-7] "
			echo "M A I N - M E N U"
			echo "1) System Status"
			echo "2) Backup"
			echo "3) Network"
			echo "4) Services"
			echo "5) User Management"
			echo "6) File Management"
			echo "7) Exit"
		;;
		"Network")
			Network
		;;
		"Services")
			Services
		;;
		"User Management")
			User_Management
		;;
		"File Management")
			File_Management
		;;
		"Exit")
			echo "Exiting..."
			break
		;;
		*)
			echo "Error: Wrong input"
		;;
	esac
done
}

#System Status
System_Status() {
echo "S Y S T E M - S T A T U S"
PS3="Enter an option [1-5] "
ssMenu=("Memory Status" "CPU Temperature" "Active Processes" "Stop and Close Process" "Main Menu")
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
			break
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
echo "User Management"
}

#File Management
File_Management() {
echo "File Management"
}

Main_Menu_Function
echo $?
