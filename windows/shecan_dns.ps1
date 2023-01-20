param (    
    [string]$a,
    [string]$d1 = "178.22.122.100",# Change to the desired primary DNS server IP
    [string]$d2  = "185.51.200.2",# Change to the desired secondary DNS server IP
    [switch]$r
)

if ([string]::IsNullOrEmpty($a)) {
    # Use the current active ethernet adapter
    $adapter = Get-NetAdapter | Where-Object {$_.status -eq "up"} | Select-Object -Last 1
    $adapterName = $adapter.Name
}else {
    $adapterName = $a   
}

Write-Host -NoNewline "Is this the correct ethernet adapter: '"
Write-Host -NoNewline "$adapterName" -ForegroundColor Green
Write-Host -NoNewline "' ? (yes/no):"

$confirm = Read-Host

if ($confirm -eq "yes") {
    $adapter = Get-NetAdapter -Name $adapterName
    if ($r) {
        $ipv4 = Get-NetIPInterface -InterfaceIndex $adapter.ifIndex | Where-Object {$_.AddressFamily -eq "IPv4"}
        Set-DnsClientServerAddress -InterfaceIndex $ipv4.ifIndex -ResetServerAddresses
        Write-Host "`nDNS settings have been reset`n"
    } else {
        Set-DnsClientServerAddress -InterfaceAlias $adapter.InterfaceAlias -ServerAddresses ($d1, $d2)
        Write-Host "`nDone, DNS settings have been set`n"
    }
} else {
    Write-Host "`nAborted, Please select the correct adapter and re-run the script`n"
}