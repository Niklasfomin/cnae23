#!/bin/bash

# Function to check if a file with a specific suffix exists
file_exists() {
    local file_suffix=$1
    [[ -f locustfile${file_suffix}.py ]]
}

# Prompt the user for the frontend address
read -p "Enter the frontend address (e.g., example.com): " FRONTEND_ADDR

# Display the locust command with locust file options
echo "Running Locust command:"
echo "locust --host=\"http://${FRONTEND_ADDR}\" --headless -u \"${USERS:-10}\" -f <LOCUST_FILE> 2>&1"

# Prompt the user to choose a locust file
PS3="Please choose a locust file (enter the number): "
options=("Default (locustfile.py)" "Option 1 (locustfile_1.py)" "Option 2 (locustfile_2.py)" "Option 3 (locustfile_3.py)")
select opt in "${options[@]}"; do
    case $REPLY in
        1)
            locust_file="locustfile.py"
            break
            ;;
        2)
            if file_exists "_1"; then
                locust_file="locustfile_1.py"
                break
            else
                echo "Option 1 (locustfile_1.py) not found. Please choose another option."
            fi
            ;;
        3)
            if file_exists "_2"; then
                locust_file="locustfile_2.py"
                break
            else
                echo "Option 2 (locustfile_2.py) not found. Please choose another option."
            fi
            ;;
        4)
            if file_exists "_3"; then
                locust_file="locustfile_3.py"
                break
            else
                echo "Option 3 (locustfile_3.py) not found. Please choose another option."
            fi
            ;;
        *)
            echo "Invalid choice. Please select a valid option (1, 2, 3, or default)."
            ;;
    esac
done

# Run Locust with the chosen locust file
locust --host="http://${FRONTEND_ADDR}" --headless -u "${USERS:-10}" -f "${locust_file}" 2>&1
