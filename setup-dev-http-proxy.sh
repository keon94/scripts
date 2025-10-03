#!/bin/sh

# tether-fi specific
# http_proxy=192.168.49.1:8228

#every-proxy (Android)


if [ $# != 1 ]; then
    printf "incorrect args\n\n"
    exit 1
fi

if [ "$1" == "true" ]; then
    printf "setting http_proxy\n"   
    git config --global http.proxy http://$LOCAL_HTTP_PROXY
    #git config --global http.proxy socks5://$LOCAL_SOCKS_PROXY
    printf "set git proxy\n"
    export http_proxy="http://$http_proxy"
    export ALL_PROXY=socks5h://$LOCAL_SOCKS_PROXY
    printf "set Go proxy\n"
else
    printf "unsetting proxy\n"
    git config --global --unset http.proxy
    export -n http_proxy
    export -n ALL_PROXY
fi