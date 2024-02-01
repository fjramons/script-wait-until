# Helper function to wait for an event with timeout in Bash script

## Rationale

The helper function `monitor_condition`, defined at the `wait-until.sh` file, aims to simplify the treatment in bash scripts of conditions that need to be met before continuing the execution.

This helper functions is a convenient alternative to the well-known `timeout` command when the condition is not the result of a simple command run, but requires a series of verifications and conditionals to be made and creating separate standalone scripts is not feasible or advisable.

The helper function is designed to wait for the condition only until a timeout limit, when the execution would return an abnormal status. Hence, this status must **always be tested before continuing the execution**, since there is no guarantee that the condition has been met during the period.

## Syntax

```bash
monitor_condition <condition> [<message> [<timeout> [<polling_interval>]]]
```

where:

- `<condition>`: Condition to be met before continuing execution. For complex conditions, it is strongly advised that the expression is enclosed in a helper function and this function name is passed as conditional.
- `<message>` (optional): Keepalive message to print to stdout during each check of the condition (default: None).
- `<timeout>` (optional): Timeout to abort the wait for the condition and return control (default: 5 minutes).
  - Note that due to the possibility of a timeout expiry, the contents of `$?` must be tested before continuing, since the condition may have failed.
- `<polling_interval>` (optional): Period between condition checks (default: 2 seconds).

## Example of use in a script

```bash
#!/bin/bash

# Source the helper function
source ./wait-until.sh

# Begin script execution

. . .

# Helper function which checks a condition
# E.g.
# - Check if the pod `my_pod` is ready in a K8s cluster
my_condition() {
    kubectl get pod/my_pod -n my_namespace | grep -i ready > /dev/null 2>&1
}

# Waits until the pod is ready - timeouts if not ready in 5 minutes (default)
monitor_condition my_condition "Waiting por the pod to be ready...\n"

# If timed-out, the script must exit ungracefully
[ ! $? ] || echo "ABORTING: The pod could not reach the ready state." && exit 1

# Otherwise, the script continues normally

. . .

```

## Some easy examples

Some examples can interactively run here (in all of them, it checks if the file `myfile` is created):

```bash
./examples.sh
```

During sucessive executions you may try to create/remove the file in a different terminal and see how it reacts:

```bash
touch myfile
# rm myfile
```
