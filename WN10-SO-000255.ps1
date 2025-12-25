<#
.SYNOPSIS
    This PowerShell script sets User Account Control (UAC) to automatically deny elevation requests for standard users on Windows 10.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2024-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000230

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-CC-000230).ps1 
#>

# ============================================================
# STIG ID: WN10-SO-000255
# Title  : User Account Control must automatically deny elevation requests for standard users
# Purpose: Prevent standard users from elevating privileges without authorization
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path for UAC settings
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Set ConsentPromptBehaviorUser = 0 (Automatically deny elevation requests for standard users)
New-ItemProperty `
    -Path $RegPath `
    -Name "ConsentPromptBehaviorUser" `
    -PropertyType DWord `
    -Value 0 `
    -Force | Out-Null

Write-Output "WN10-SO-000255 remediation applied: Standard users will automatically be denied elevation requests."

# Optional: verify the setting
$setting = Get-ItemProperty -Path $RegPath -Name "ConsentPromptBehaviorUser"
Write-Output "Current ConsentPromptBehaviorUser value: $($setting.ConsentPromptBehaviorUser)"


