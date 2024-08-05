#!/bin/bash

# Path to the authentication log
LOG_FILE="/var/log/auth_log.log"

# Path to the output log for suspicious activities
OUTPUT_LOG="/home/ubuntu/suspicious_activity.log"

# Path to store the last line number processed
LAST_LINE_FILE="/home/ubuntu/last_line_number.txt"

# Check if the last line file exists, if not create it and initialize to 0
if [ ! -f "$LAST_LINE_FILE" ]; then
    echo "0" > "$LAST_LINE_FILE"
fi

# Read the last line processed
LAST_LINE=$(cat "$LAST_LINE_FILE")

# Calculate the number of lines currently in the log file
CURRENT_LINE=$(wc -l < "$LOG_FILE")

# If new lines are added since the last check, process them
if [ "$CURRENT_LINE" -gt "$LAST_LINE" ]; then
    # Process new lines only
    tail -n +$((LAST_LINE+1)) "$LOG_FILE" | grep -E -i "failed|unauthorized|invalid" >> "$OUTPUT_LOG"
    # Update the last line processed
    echo "$CURRENT_LINE" > "$LAST_LINE_FILE"
fi
