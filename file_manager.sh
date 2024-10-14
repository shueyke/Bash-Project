#!/bin/bash

# Function to display usage information
usage() {
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
            path="$OPTARG"
            ;;
        h)
            usage
            ;;
        \?)
            usage
            ;;
    esac
done

# Check if at least one option is provided
if [ -z "$owner" ] && [ -z "$permissions" ]; then
    echo "Error: You must specify at least one of -o or -p."
    usage
fi

# Check if the file/directory exists
if [ -n "$path" ] && [ ! -e "$path" ]; then
    echo "Error: '$path' does not exist."
    exit 1
fi

# Validate ownership if specified
if [ -n "$owner" ]; then
    if validate_ownership "$owner"; then
        sudo chown "$owner" "$path"
        echo "Ownership of '$path' changed to '$owner'."
    else
        echo "Error: Invalid ownership format. Use 'user:group'."
        exit 1
    fi
fi

# Validate permissions if specified
if [ -n "$permissions" ]; then
    if validate_permissions "$permissions"; then
        chmod "$permissions" "$path"
        echo "Permissions of '$path' changed to '$permissions'."
    else
        echo "Error: Invalid permissions format. Use numeric (e.g., 755)."
        exit 1
    fi
fi