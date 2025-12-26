<#
.SYNOPSIS
    This PowerShell script ensures secure RPC communication for RDSH.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-26
    Last Modified   : 2025-12-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000005

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-AC-000005).ps1 
#>
# ============================================================
# STIG ID: WN11-CC-000285
# Title : Require secure RPC communication for RDSH
# Purpose:
#   Enforce encrypted and authenticated RPC communications
#   for Remote Desktop Session Host.
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Output "Applying WN11-CC-000285 remediation..."

# Registry path and value
$RegPath  = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$RegName  = "fEncryptRPCTraffic"
$RegValue = 1

# Create the registry key if it does not exist
If (-not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Enable secure RPC communication
New-ItemProperty `
    -Path $RegPath `
    -Name $RegName `
    -PropertyType DWord `
    -Value $RegValue `
    -Force | Out-Null

Write-Output "Secure RPC communication for Remote Desktop Session Host enabled."

# Verify setting
$verify = Get-ItemProperty -Path $RegPath -Name $RegName
Write-Output "fEncryptRPCTraffic = $($verify.fEncryptRPCTraffic)"

Write-Output "WN11-CC-000285 remediation applied successfully."
Write-Output "A system restart or RDS service restart may be required."

