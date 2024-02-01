#!/bin/bash

# Import function
. ./wait-until.sh

# CONDITION TO CHECK
# - Example: Check if `myfile` exists
my_condition() {
    ls myfile > /dev/null 2>&1
}

echo "During any of the following examples feel free to open another terminal and create/delete a file called \`myfile\` to see the effect..."
read -p "Press enter to continue"
echo
echo

# EXAMPLE 1: Wait as much as 10 seconds
echo "EXAMPLE 1: Wait as much as 10 seconds"
echo "========================================="
read -p "Press enter to continue"
echo
monitor_condition my_condition "Waiting a bit...\n" 10
echo -e "Result: $?\n"

# EXAMPLE 2: Wait as much as 10 seconds, poll every second
echo "EXAMPLE 2: Wait as much as 10 seconds, poll every second"
echo "============================================================"
read -p "Press enter to continue"
echo
monitor_condition my_condition "Waiting again...\n" 10 1
echo -e "Result: $?\n"

# EXAMPLE 3: Wait as much as 10 seconds, no polling message
echo "EXAMPLE 3: Wait as much as 10 seconds, no polling message"
echo "============================================================="
read -p "Press enter to continue"
echo
monitor_condition my_condition "" 10
echo -e "Result: $?\n"

# EXAMPLE 4: Wait as much as 30 seconds, minimal polling message
echo "EXAMPLE 4: Wait as much as 30 seconds, minimal polling message"
echo "=================================================================="
read -p "Press enter to continue"
echo
monitor_condition my_condition "." 30 1
echo -e "\nResult: $?\n"

# EXAMPLE 5: Wait as much as the default timeout (5 minutes), no polling message
echo "EXAMPLE 5: Wait as much as the default timeout (5 minutes), no polling message"
echo "=================================================================================="
read -p "Press enter to continue"
echo
monitor_condition my_condition
echo -e "Result: $?\n"
