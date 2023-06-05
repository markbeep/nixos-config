# Tests the whole configuration for syntax errors
`timeout 30s bash tests/command.sh`
err=$?
if [ $err == 0 ] || [ $err == 124 ]; then
    echo "Success!";
    exit 0
else
    echo "Error!";
    exit 1
fi
