#!/bin/sh

function get_weather() {
    local city="$1"
    local url="$2"
    local html=$(curl -s "$url")
    local temp=$(echo "$html" | grep -oEi ".{0,1}Now</span></h3><div data-testid=\"SegmentHighTemp\" class=\"_-_-components-src-molecule-WeatherTable-Column-Column--temp--1sO_J\"><span data-testid=\"TemperatureValue\">.{0,3}" | tail -c 5 | grep -oE '[0-9]{1,3}')
    local feels_like=$(echo "$html" | grep -oEi ".{0,1}feelsLikeTempValue--2icPt\">.{0,3}" | tail -c 5 | grep -oE '[0-9]{1,3}')
    local time=$(date "+%Y-%m-%d %H:%M")
    printf "$city @ $time => Temp=${temp}F, Feels Like=${feels_like}F\n"
}

while true; do
    get_weather "Ahvaz" https://weather.com/weather/today/l/54ccca5a92458497ad78d576da2c7924c5d76709d20033dbb794b9e8f6651d68
    get_weather "Abadan" https://weather.com/weather/today/l/76e0e75999e17c34ca1816932ac42bc79355937d3e5d4d1c2d8e010aff07091a
    sleep 800 # 15 mins
done