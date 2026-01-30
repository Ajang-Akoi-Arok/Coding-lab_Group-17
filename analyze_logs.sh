#!/bin/bash

# Intelligent Analysis Script
# Purpose: Analyze log files and generate reports

# Configuration - EXACTLY as specified in requirements
LOG_FILES=("heart_rate.log" "temperature.log" "water_usage.log")
LOG_NAMES=("Heart Rate" "Temperature" "Water Usage")
REPORT_FILE="hospital_data/reports/analysis_report.txt"

# Function to display menu - EXACT format from requirements
show_menu() {
    echo "Select log file to analyze:"
    echo "1) Heart Rate (heart_rate.log)"
    echo "2) Temperature (temperature.log)"
    echo "3) Water Usage (water_usage.log)"
    printf "Enter choice (1-3): "
}

# Main execution
main() {
    # Display menu and get user input
    show_menu
    read -r choice
    
    # Validate user input (only 1,2, or 3)
    if [[ ! "$choice" =~ ^[1-3]$ ]]; then
        echo "Error: Invalid choice. Please enter a number between 1 and 3." >&2
        exit 1
    fi
    
    # Get selected log details
    index=$((choice-1))
    log_file="${LOG_FILES[$index]}"
    log_name="${LOG_NAMES[$index]}"
    
    # Since actual file is heart_rate_log.log but menu shows heart_rate.log
    # We'll check both possibilities
    actual_file="${log_file%.*}_log.log"
    log_path1="hospital_data/active_logs/$log_file"
    log_path2="hospital_data/active_logs/$actual_file"
    
    # Determine which file exists
    if [ -f "$log_path1" ]; then
        log_path="$log_path1"
    elif [ -f "$log_path2" ]; then
        log_path="$log_path2"
    else
        echo "Error: Log file '$log_file' not found." >&2
        exit 1
    fi
    
    echo "Analyzing $log_name log ($log_file)..."
    
    # Check if log file has content
    if [ ! -s "$log_path" ]; then
        echo "No data found in log file."
        total_lines=0
    else
        # Count total lines
        total_lines=$(wc -l < "$log_path")
        
        # Count occurrences of each device
        # DEVICE IS 3rd COLUMN: date(1) time(2) device(3) data(4)
        echo "Device analysis for $log_name log:"
        echo "========================================="
        
        # Process each unique device - device is 3rd column
        awk '{print $3}' "$log_path" | sort | uniq -c | while read count device; do
            # Get first timestamp for this device (date and time are 1st and 2nd columns)
            first_entry=$(grep " $device " "$log_path" | head -1 | awk '{print $1, $2}')
            
            # Get last timestamp for this device
            last_entry=$(grep " $device " "$log_path" | tail -1 | awk '{print $1, $2}')
            
            echo "$device: $count entries (First: $first_entry, Last: $last_entry)"
        done
    fi
    
    echo ""
    echo "Total log entries: $total_lines"
    
    # Create reports directory if it doesn't exist
    mkdir -p "$(dirname "$REPORT_FILE")"
    
    # Append results to reports/analysis_report.txt
    {
        echo "========================================="
        echo "Analysis Report - $(date '+%Y-%m-%d %H:%M:%S')"
        echo "========================================="
        echo "Log File: $log_name ($log_file)"
        echo "Analysis Date: $(date '+%Y-%m-%d %H:%M:%S')"
        echo ""
        
        if [ $total_lines -gt 0 ]; then
            echo "Device analysis for $log_name log:"
            echo "========================================="
            
            # Re-process for report - device is 3rd column
            awk '{print $3}' "$log_path" | sort | uniq -c | while read count device; do
                first_entry=$(grep " $device " "$log_path" | head -1 | awk '{print $1, $2}')
                last_entry=$(grep " $device " "$log_path" | tail -1 | awk '{print $1, $2}')
                echo "$device: $count entries (First: $first_entry, Last: $last_entry)"
            done
        fi
        
        echo ""
        echo "Total log entries: $total_lines"
        echo ""
    } >> "$REPORT_FILE"
    
    echo "Report appended to hospital_data/reports/analysis_report.txt"
}

# Run main function
main
