# !/bin/sh

function get_weather() {
    local city="$1"
    local url="$2"
    local html=$(curl -s "$url")
    local temp=$(echo "$html" | grep -oEi ".{0,1}Now</span></h3><div data-testid=\"SegmentHighTemp\".*-testid=\"TemperatureValue\">.{0,3}" | tail -c 5 | grep -oE '[0-9]{1,3}')
    local feels_like=$(echo "$html" | grep -oEi ".{0,1}feelsLikeTempValue--2aogo\">.{0,3}" | tail -c 10 | grep -oE '[0-9]{1,3}')
    local time=$(date "+%Y-%m-%d %H:%M")
    printf "$city @ $time => Temp=${temp}F, Feels Like=${feels_like}F\n"
}

while true; do
    #get_weather "Ahvaz" https://weather.com/weather/today/l/54ccca5a92458497ad78d576da2c7924c5d76709d20033dbb794b9e8f6651d68
    #get_weather "Abadan" https://weather.com/weather/today/l/76e0e75999e17c34ca1816932ac42bc79355937d3e5d4d1c2d8e010aff07091a
	get_weather "Denver" https://weather.com/weather/today/l/675c2b6342b3512ea4f15bc9070663be6e36cc4bf61056076c500098c8eb3bbe
	get_weather "Cheyenne" https://weather.com/weather/today/l/b49a92f375f5792cf5a9f0a9e90c7b900a2cc46603c11ad2989876fe7e9d130e
	get_weather "Laramie" https://weather.com/weather/today/l/b669ad487cdef38648b4773305c0d53ba67fbc503ae5db3a815ff228936adf99
    sleep 300 # 15 mins
done