<#
.SYNOPSIS
    enables failure auditing for process creation to detect unsuccessful attempts to execute commands or processes, providing visibility into potentially malicious activity.
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
# STIG ID: WN10-AU-000585
# Title  : Command line / process auditing events enabled for failures
# Purpose: Detect failed process creation attempts for security monitoring
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Enable failure auditing for Process Creation
$subcategory = "Process Creation"

Write-Output "Applying WN10-AU-000585: Enabling failure auditing for Process Creation..."
AuditPol.exe /set /subcategory:"$subcategory" /success:disable /failure:enable

# Verify the setting
Write-Output "Verifying setting..."
AuditPol.exe /get /subcategory:"$subcategory"

Write-Output "WN10-AU-000585 remediation applied successfully."
