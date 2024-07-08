#!/usr/bin/env bash

output=$(wit-bindgen rust --with dummy=dummy --check ./spec/wit/skyforge.v1.wit 2>&1)
exit_code=$?

if [ $exit_code -eq 1 ] && echo "$output" | grep -q "Error: unused remappings"; then
    echo "Ignoring unused remappings error."
    exit 0
fi

if [ $exit_code -eq 0 ]; then
    echo "WIT file is correct."
else
    echo "WIT file has errors."
    echo "$output"
fi

exit $exit_code
