#!/bin/bash

echo -e "Select log file to analyze:\n"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"

read -p "Enter choice (1-3): " choice_log_number

REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"

# Create report directory if it doesn't exist
mkdir -p "$REPORT_DIR"

timestamp=$(date +"%Y-%m-%d %H:%M:%S")

case $choice_log_number in
    1)
        LOG_FILE="active_logs/heart_rate_log.log"
        LOG_NAME="Heart Rate"
        ;;
    2)
        LOG_FILE="active_logs/temperature_log.log"
        LOG_NAME="Temperature"
        ;;
    3)
        LOG_FILE="active_logs/water_usage_log.log"
        LOG_NAME="Water Usage"
        ;;
    *)
        echo "Unacceptable Number. Only 1-3 are allowed!"
        exit 1
        ;;
esac


if [ ! -f "$LOG_FILE" ]; then
    echo "Log file $LOG_FILE is missing! Cannot analyze."
    exit 1
fi

if [ ! -s "$LOG_FILE" ]; then
    echo "Log file $LOG_FILE is empty! No data to analyze."
    exit 1
fi

echo "Analyzing $LOG_NAME log..."

{
    echo "=================================================="
    echo "Analysis Timestamp: $timestamp"
    echo "Log Type: $LOG_NAME"
    echo "Log File: $LOG_FILE"
    echo
    echo "Device Statistics:"
    echo "------------------"

    # Count occurrences per device
    awk '{print $3}' "$LOG_FILE" | sort | uniq -c | while read count device
    do
        first_entry=$(grep "$device" "$LOG_FILE" | head -n 1 | awk '{print $1, $2}')
        last_entry=$(grep "$device" "$LOG_FILE" | tail -n 1 | awk '{print $1, $2}')

        echo "Device: $device"
        echo "  Total Entries: $count"
        echo "  First Entry:  $first_entry"
        echo "  Last Entry:   $last_entry"
        echo
    done
} >> "$REPORT_FILE"

echo "Analysis complete. Results appended to $REPORT_FILE"
