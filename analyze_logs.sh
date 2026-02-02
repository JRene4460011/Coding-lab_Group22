#!/bin/bash

echo -e "Select log file to analyze:\n"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"

read -p "Enter choice (1-3): " choice_log_number

REPORT_DIR="reports"
REPORT_FILE="$REPORT_DIR/analysis_report.txt"
