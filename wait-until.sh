#!/bin/bash

monitor_condition() {
    local CONDITION="$1"        # Function with the condition
    local MESSAGE="${2:-}"      # Message during each check
    local TIMEOUT="${3:-300}"   # Timeout, in seconds (default: 5 minutes)
    local STEP="${4:-2}"        # Polling period (default: 2 seconds)

    # echo ${TIMEOUT}
    until "${CONDITION}" || [ ${TIMEOUT} -le 0 ]
    do
        echo -en "${MESSAGE}"

        ((TIMEOUT-=${STEP}))
        # echo ${TIMEOUT}

        sleep "${STEP}"
    done

    "${CONDITION}"
}
