#!/bin/bash

echo -e "Select log to archive: \n"
echo -e "1) Heart Rate"
echo -e "2) Temperature"
echo -e "3) Water Usage"

read -p  "Enter choice (1-3):"  choice_log_number

timestamp=$(date +"%Y-%m-%d_%H-%M-%S")

case $choice_log_number in
	1)
		src="hospital_data/active_logs/heart_rate.log"
		dest="hospital_data/archived_logs/heart_data_archive/heart_rate_${timestamp}.log"
		
		if [ -f "$src" ]; then
			echo "Archiving heart_rate.log..."
			mv "$src" "$dest" && touch "$src"
			echo "Successfuly archived to $dest"
		else
			echo "Log file heart_rate.log is missing! Therefore, it cannot be archived."
		fi
		;;
	2)
		src="hospital_data/active_logs/temperature.log"
                dest="hospital_data/archived_logs/temperature_data_archive/temperature_${timestamp}.log"

                if [ -f "$src" ]; then
			echo "archiving temperature.log..."                        
			mv "$src" "$dest" && touch "$src"
                        echo "Successfuly archived to $dest"
                else
                        echo "Log file temperature.log is missing! Therefore, it cannot be archived."
                fi
		;;

	3)
		src="hospital_data/active_logs/water_usage.log"
                dest="hospital_data/archived_logs/water_usage_data_archive/water_usage_${timestamp}.log"

                if [ -f "$src" ]; then
                        echo "archiving water_usage.log..."
                        mv "$src" "$dest" && touch "$src"
                        echo "Successfuly archived to $dest"
                else
                        echo "Log file water_usage.log is missing! Therefore, it cannot be archived."
                fi
                ;;

	*)
		echo "Unacceptable Number. Only 1-3 are allowed!"
		;;
esac

