<#
.SYNOPSIS
    This PowerShell script configures File Share access auditing for successes on Windows 10 using Advanced Audit Policy.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2024-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000082

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-AU-000082).ps1 
#>

# ============================================================
# STIG ID: WN10-AU-000082
# Title  : Audit Object Access - File Share successes
# Purpose: Detect and log successful access to file shares
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Enable auditing of File Share successes
$subcategory = "File Share"

Write-Output "Applying WN10-AU-000082: Enabling success auditing for File Share access..."
AuditPol.exe /set /subcategory:"$subcategory" /success:enable /failure:disable

# Verify the setting
Write-Output "Verifying setting..."
AuditPol.exe /get /subcategory:"$subcategory"

Write-Output "WN10-AU-000082 remediation applied successfully."
