#! /bin/sh

# use exec to avoid nginx as a child process
# important for handling signals correctly
exec nginx -g "daemon off;"