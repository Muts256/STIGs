<#
.SYNOPSIS
    This PowerShell script ensures the system is configured to audit Account Management - User Account Management failures

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-26
    Last Modified   : 2025-12-26
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AU-000035

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN11-AU-000035).ps1 
#>
#==============================================================================
# WN11-AU-000035
# Audit User Account Management Failures
#==============================================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Enable Advanced Audit Policy enforcement over legacy policy
auditpol /set /category:"Account Management" /subcategory:"User Account Management" /failure:enable

Write-Output "WN11-AU-000035 remediated: Audit User Account Management Failures enabled."
