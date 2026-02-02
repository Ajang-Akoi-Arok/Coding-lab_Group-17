#!/bin/bash

# Script: archive_logs.sh
# Purpose: Archive Hospital log files safely with timestamp

LOG_DIR="hospital_data/active_logs"
ARCHIVE_DIR="hospital_data/archived_logs"

# Ensure archive directories exist
mkdir -p "$ARCHIVE_DIR/heart_data_archive"
mkdir -p "$ARCHIVE_DIR/temperature_data_archive"
mkdir -p "$ARCHIVE_DIR/water_usage_data_archive"

echo "Select a log to archive:"
echo "1) Heart Rate"
echo "2) Temperature"
echo "3) Water Usage"
read -p "Enter Choice (1-3): " choice

# Validate Input
if [[ ! "$choice" =~ ^[1-3]$ ]]; then
    echo "Error: Invalid Choice. Please Enter 1, 2, or 3."
    exit 1
fi

# Map choice to log file and archive directory
case $choice in
    1)
        Log_file="heart_rate.log"
        Log_name="Heart Rate"
        archive_subdir="heart_data_archive"
        ;;
    2)
        Log_file="temperature.log"
        Log_name="Temperature"
        archive_subdir="temperature_data_archive"
        ;;
    3)
        Log_file="water_usage.log"
        Log_name="Water Usage"
        archive_subdir="water_usage_data_archive"
        ;;
esac

log_path="$LOG_DIR/$Log_file"
archive_path="$ARCHIVE_DIR/$archive_subdir"

# Check if Log file exists
if [ ! -f "$log_path" ]; then
    echo "Error: Log file $Log_file not found in $LOG_DIR!"
    exit 1
fi

# Check if archive directory exists
if [ ! -d "$archive_path" ]; then
    echo "Error: Archive directory $archive_path not found!"
    exit 1
fi

echo "Archiving $Log_name log..."

# Generate timestamp for archive filename
timestamp=$(date '+%Y-%m-%d_%H:%M:%S')
archive_file="$archive_path/${Log_file%.*}_${timestamp}.log"

# Archive the log file
if mv "$log_path" "$archive_file"; then
    echo "Successfully archived to $archive_file"
    
    # Create new empty log file for continued monitoring
    touch "$log_path"
    echo "Created new empty log file: $log_path"
else
    echo "Error: Failed to archive Log file!"
    exit 1
fi
