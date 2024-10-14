#!/bin/bash

# Function to display usage information
display_usage() {
    echo "Usage: $0 -o <owner:user> -p <permissions> -f <file/directory>"
    echo "Options:"
    echo "  -o <owner:user>      Change the ownership to the specified user and group."
    echo "  -p <permissions>     Change the permissions to the specified numeric value."
    echo "  -f <file/directory>  Specify the file or directory to change."
    echo "  -h                   Display this help message."
    exit 1
}

# Validate permissions format (numeric only)
validate_permissions() {
    [[ $1 =~ ^[0-7]{3,4}$ ]]
}

# Validate ownership format (user:group)
validate_ownership() {
    [[ $1 =~ ^[a-zA-Z0-9._-]+:[a-zA-Z0-9._-]+$ ]]
}

# Parse command-line options
while getopts "o:p:f:h" opt; do
    case $opt in
        o)
            owner="$OPTARG"
            ;;
        p)
            permissions="$OPTARG"
            ;;
        f)
            filepath="$OPTARG"
            ;;
        h)
            display_usage
            exit 0
            ;;
        \?)
            display_usage
            exit 0
            ;;
        :) #no arguement
            echo "option $OPTARG requires and arguement"
            display_usage
            exit 1
            ;;
    esac
done

# Check if at least one option is provided
if [ -z "$owner" ] && [ -z "$permissions" ]; then
    echo "Error: You must specify at least one of -o or -p."
    usage
fi

# Check if the file/directory exists
if [ -n "$filepath" ] && [ ! -e "$filepath" ]; then
    echo "Error: '$filepath' does not exist."
    exit 1
fi

# Validate ownership if specified
if [ -n "$owner" ]; then
    if validate_ownership "$owner"; then
        sudo chown "$owner" "$filepath"
        echo "Ownership of '$filepath' changed to '$owner'."
        echo " "
        ls -l $filepath
        echo " "
    else
        echo "Error: Invalid ownership format. Use 'user:group'."
        exit 1
    fi
fi

# Validate permissions if specified
if [ -n "$permissions" ]; then
    if validate_permissions "$permissions"; then
        chmod "$permissions" "$filepath"
        echo "Permissions of '$filepath' changed to '$permissions'."
        echo " "
        ls -l $path
        echo " "
    else
        echo "Error: Invalid permissions format. Use numeric (e.g., 755)."
        exit 1
    fi
fi