#!/bin/bash
# Contribution by James Ntwali
# This script assumes $LOG_FILE and $LOG_NAME are already defined externally

REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"

# Create report directory if it doesn't exist
mkdir -p "$REPORT_DIR"

echo "Analyzing $LOG_NAME log..."

{
    echo "=================================================="
    echo "Analysis Timestamp: $(date +"%Y-%m-%d %H:%M:%S")"
    echo "Log Type: $LOG_NAME"
    echo "Log File: $LOG_FILE"
    echo
    echo "Device Statistics:"
    echo "------------------"

    # Count occurrences per device and report first & last entry
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

