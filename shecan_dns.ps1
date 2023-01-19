param (    
    [string]$a,
    [switch]$d=$False
)

if ([string]::IsNullOrEmpty($a)) {
    # Use the current active ethernet adapter
    $adapter = Get-NetAdapter | Where-Object {$_.status -eq "up"} | Select-Object -Last 1
    $adapterName = $adapter.Name
}else {
    $adapterName = $a   
}
$confirm = Read-Host "Is this the correct ethernet adapter: $adapterName ? (yes/no)"

if ($confirm -eq "yes") {
    $adapter = Get-NetAdapter -Name $adapterName
    if ($d) {
        # Set-DnsClientServerAddress -InterfaceAlias $adapter.InterfaceAlias -ServerAddresses $null
        # Clear-DnsClientServerAddress -InterfaceIndex $adapter.ifIndex
        $ipv4 = Get-NetIPInterface -InterfaceIndex $adapter.ifIndex | Where-Object {$_.AddressFamily -eq "IPv4"}
        # $ipv4.DnsServer = $null
        # Set-DnsClientServerAddress -InterfaceIndex $ipv4.ifIndex -ServerAddresses $ipv4.DnsServer
        # Set-DnsClient -InterfaceIndex $ipv4.ifIndex -UseSuffixWhileRegistering $false -UseDomainNameDevolution $false -UseDhcp $true
        Set-DnsClientServerAddress -InterfaceIndex $ipv4.ifIndex -ResetServerAddresses
        Write-Host "DNS settings have been reset"
    } else {
        $primaryDnsServer = "178.22.122.100" # Change to the desired primary DNS server IP
        $secondaryDnsServer = "185.51.200.2" # Change to the desired secondary DNS server IP
        # $dnsConfig = (Get-NetIPConfiguration -InterfaceAlias $adapter.InterfaceAlias).DNSServer
        # $dnsConfig.ServerAddresses = 
        # Set-DnsClientServerAddress -InterfaceAlias $adapter.InterfaceAlias -ServerAddresses $dnsConfig.ServerAddresses
        Set-DnsClientServerAddress -InterfaceAlias $adapter.InterfaceAlias -ServerAddresses ($primaryDnsServer, $secondaryDnsServer)
    }
} else {
    Write-Host "Aborted, Please select the correct adapter and re-run the script"
}