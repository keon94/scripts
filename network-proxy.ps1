# Define the SSID you want to use the proxy with
$targetSSID = "DIRECT-TF-TetherFi"  # Replace with your SSID
# Define your proxy server and port
$proxyServer = "http://192.168.49.1:8228"  # Replace with your proxy server
#$proxyBypass = "<local>"  # Bypass for local addresses

# Get the current Wi-Fi SSID
$wifiSSID = (netsh wlan show interfaces | Select-String "SSID" | Select-Object -First 1).ToString().Split(":")[1].Trim()

if ($wifiSSID -eq $targetSSID) {
    # Set the proxy settings
    netsh winhttp set proxy $proxyServer
    #netsh winhttp set proxy $proxyServer -b $proxyBypass
    Write-Host "Proxy set for SSID: $targetSSID"
} else {
    # Reset the proxy settings
    netsh winhttp reset proxy
    Write-Host "Proxy reset; not connected to $targetSSID"
}