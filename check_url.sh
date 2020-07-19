if curl --output /dev/null --silent --fail -r 0-0 "$1"; then
  echo "URL exists: $1"
else
  echo "URL does not exist: $1"
fi