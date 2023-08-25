#!/bin/bash

echo "--------------------------------------------"
echo "| This is an external loadgenerator         |"
echo "| customized for the Online Boutique -      |"
echo "| Please enter your configuration:          |"
echo "--------------------------------------------"
echo ""

# Prompt the user for the frontend address
read -p "Enter the frontend address (e.g., 127.0.0.1): " FRONTEND_ADDR
echo "---------------------------------------------------"
echo ""

# Prompt the user for the number of users
read -p "Enter the number of users: " USERS
echo "---------------------------------------------------"
echo ""

# Set the locust file 
locust_file="locustfile_new.py"

echo "---------------------------------------------------"
echo ""
echo "Running locust script with the following configuration on ${FRONTEND_ADDR}:"
echo ""
echo "locust --host=\"http://${FRONTEND_ADDR}\" --headless -u \"${USERS:-10}\" -f ${locust_file} 2>&1"

sleep 3

# Run Locust with the chosen locust file
locust --host="http://${FRONTEND_ADDR}" --headless -u "${USERS}" -f "${locust_file}" 2>&1
