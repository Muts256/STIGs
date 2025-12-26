<#
.SYNOPSIS
    This PowerShell script ensures Windows Update Delivery Optimization does NOT download updates from Internet peers.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-26
    Last Modified   : 2025-12-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000206

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN11-CC-000206).ps1 
#>
#============================================================================================
# WN11-CC-000206
# Ensure Windows Update Delivery Optimization does NOT download updates from Internet peers
#============================================================================================
# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path for Delivery Optimization download mode
$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\DeliveryOptimization"
$regName = "DODownloadMode"

# Acceptable values (any except Internet)
# 0 = HTTP only, 1 = LAN, 2 = Group, 99 = Simple, 100 = Bypass
# Example: Set to 0 (HTTP only, safest option)
$regValue = 0

# Create registry path if it doesn't exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set Download Mode
New-ItemProperty `
    -Path $regPath `
    -Name $regName `
    -Value $regValue `
    -PropertyType DWORD `
    -Force | Out-Null

Write-Output "WN11-CC-000206 remediated: Delivery Optimization Download Mode set to $regValue (no Internet peers)."
