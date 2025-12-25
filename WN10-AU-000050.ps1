<#
.SYNOPSIS
    This PowerShell script ensures  Audit Process Creation successes.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
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

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Enable Audit Process Creation – Success
Write-Output "Enabling Audit Process Creation – Success..."
AuditPol.exe /set /subcategory:"Process Creation" /success:enable /failure:disable

# Verify the setting
$setting = AuditPol.exe /get /subcategory:"Process Creation"
Write-Output "Current Audit Process Creation setting:"
Write-Output $setting

Write-Output "WN10-AU-000050 remediation applied successfully."
