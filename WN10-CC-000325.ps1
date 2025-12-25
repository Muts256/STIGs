<#
.SYNOPSIS
    This PowerShell script ensures re-authentication after system restarts, preventing unattended or unauthorized access due to automatic session restoration.
    
.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-CC-000325

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-CC-000325).ps1 
#>

# ============================================================
# STIG ID: WN10-CC-000325
# Title : Disable automatic sign-in of last interactive user
# Purpose:
#   Prevent Windows from automatically logging in the last
#   user after a system-initiated restart.
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Output "Applying WN10-CC-000325 remediation..."

# Registry path and value
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"
$RegName = "DisableAutomaticRestartSignOn"
$RegValue = 1

# Create registry value to disable automatic sign-in
New-ItemProperty `
    -Path $RegPath `
    -Name $RegName `
    -PropertyType DWord `
    -Value $RegValue `
    -Force | Out-Null

Write-Output "Automatic sign-in of last interactive user has been disabled."

# Verify setting
$verify = Get-ItemProperty -Path $RegPath -Name $RegName
Write-Output "DisableAutomaticRestartSignOn = $($verify.DisableAutomaticRestartSignOn)"

Write-Output "WN10-CC-000325 remediation applied successfully."
