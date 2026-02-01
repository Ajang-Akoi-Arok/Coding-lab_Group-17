# Hospital Data Monitoring & Archival System

## Project Objective
Develop an automated log management system that:
- Collects real-time patient health metrics and resource usage data
- Provides controlled log archiving with user selection
- Generates analytical reports with device statistics and temporal patterns

## Directory Structure
```
project/
├── hospital_data/
│   ├── active_logs/
│   │   ├── heart_rate_log.log
│   │   ├── temperature_log.log
│   │   └── water_usage_log.log
│   ├── archives/
│   │   ├── heart_data_archive/
│   │   ├── temperature_archive/
│   │   └── water_archive/
│   └── reports/
│       └── analysis_report.txt
├── heart_monitor.py
├── temp_sensor.py
├── water_meter.py
├── heart_rate_monitor.py
├── temperature_recorder.py
├── water_consumption.py
├── archive_logs.sh
├── analyze_logs.sh
└── README.md
```

## System Components

### Python Simulators
1. **heart_monitor.py** - Simulates 2 heart rate monitors (60-100 BPM)
2. **temp_sensor.py** - Simulates 2 temperature sensors (36.0-39.5°C)
3. **water_meter.py** - Simulates water usage meter (1-10 units)

### Shell Scripts
1. **archive_logs.sh** - Interactive archival with timestamp naming
2. **analyze_logs.sh** - Log analysis with device statistics

## Usage Instructions

### 1. Start Monitoring
```bash
python3 heart_monitor.py start
python3 temp_sensor.py start
python3 water_meter.py start
```

### 2. Verify Data Collection
```bash
tail -f hospital_data/active_logs/heart_rate_log.log
```

### 3. Archive Logs
```bash
./archive_logs.sh
```
Select option 1-3 to archive a specific log type.

### 4. Analyze Logs
```bash
./analyze_logs.sh
```
Select option 1-3 to analyze a specific log file.

### 5. Stop Monitoring
```bash
python3 heart_monitor.py stop
python3 temp_sensor.py stop
python3 water_meter.py stop
```

## Features
- **Interactive Menus**: User-friendly selection for archival and analysis
- **Timestamp Archiving**: Automatic timestamp naming (heart_rate_YYYY-MM-DD_HH:MM:SS.log)
- **Device Statistics**: Count occurrences of each device
- **Temporal Analysis**: First/last entry timestamps
- **Error Handling**: Input validation and file existence checks
- **Automated Reporting**: Results appended to analysis_report.txt

## Technical Implementation
- **Shell Scripting**: select/case statements, input validation
- **File Operations**: mv, touch, awk, grep, sort, uniq
- **Data Analysis**: Statistical analysis with Linux CLI tools
- **Process Management**: Background processes with PID files

## Thanks
