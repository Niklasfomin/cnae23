#!/bin/bash

echo "--------------------------------------------"
echo "| This is an external loadgenerator         |"
echo "| customized for the Online Boutique -      |"
echo "| Please enter your configuration:          |"
echo "--------------------------------------------"
echo ""


# Function to check if a file with a specific suffix exists
file_exists() {
    local file_suffix=$1
    [[ -f locustfile${file_suffix}.py ]]
}

# Prompt the user for the frontend address
read -p "Enter the frontend address (e.g., 127.0.0.1): " FRONTEND_ADDR
echo "---------------------------------------------------"
echo ""

# Prompt the user for the number of users
read -p "Enter the number of users: " USERS
echo "---------------------------------------------------"
echo ""

# Prompt the user to choose a locust file
echo "Workload options:"
echo "---------------------------------------------------"
echo ""
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

echo "---------------------------------------------------"
echo ""
echo "Running locust script with the following configuration on ${FRONTEND_ADDR}:"
echo ""
echo "locust --host=\"http://${FRONTEND_ADDR}\" --headless -u \"${USERS:-10}\" -f ${options} 2>&1"

sleep 3

# Run Locust with the chosen locust file
locust --host="http://${FRONTEND_ADDR}" --headless -u "${USERS}" -f "${locust_file}" 2>&1
