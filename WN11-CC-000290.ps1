<#
.SYNOPSIS
    This PowerShell script ensures Enforcing High Level encryption for Remote Desktop Services.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-26
    Last Modified   : 2025-12-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-CC-000290

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

# WN11-CC-000290
# Enforce High Level encryption for Remote Desktop Services
# STIG: Set client connection encryption level = Enabled / High Level

$regPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows NT\Terminal Services"
$regName = "MinEncryptionLevel"
$regValue = 3

# Create registry path if it does not exist
if (-not (Test-Path $regPath)) {
    New-Item -Path $regPath -Force | Out-Null
}

# Set encryption level to High (128-bit)
New-ItemProperty `
    -Path $regPath `
    -Name $regName `
    -Value $regValue `
    -PropertyType DWORD `
    -Force | Out-Null

Write-Output "WN11-CC-000290 remediated: RDP encryption set to High Level (128-bit)."
