# !/bin/bash

# Path to the log file (replace with your log file path)
LOG_FILE="../sim/result.log"

# Count the number of occurrences of "ERROR" in the log file
ERROR_COUNT=$(grep -c "ERROR" "$LOG_FILE")

# Output result based on the error count
if [ "$ERROR_COUNT" -gt 0 ]; then
    # Print the first 10 lines with "ERROR" and their line numbers
    printf "\e[31mFirst 10 errors:\e[0m\n"
    grep -n "ERROR" "$LOG_FILE" | head -n 10
    # If errors exist, print fail message in red and the number of errors
    printf "\e[31m================================================\e[0m\n\n"
    printf "\e[31mFail: Found $ERROR_COUNT error(s) in the log.\e[0m\n\n"
    printf "\e[31m================================================\e[0m\n"
else
    # If no errors, print pass message in green
    printf "\e[32m==================================\e[0m\n\n"
    printf "\e[32mPass: No errors found in the log.\e[0m\n\n"
    printf "\e[32m==================================\e[0m\n"
fi

