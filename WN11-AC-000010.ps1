<#
.SYNOPSIS
    This PowerShell script ensures the Account Lockout Threshold is 3 or fewer invalid logon attempts

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN11-AC-000010

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
# WN11-AC-000010
# Ensure Account Lockout Threshold is 3 or fewer invalid logon attempts

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Set Account Lockout Threshold to 3
$lockoutThreshold = 3

# Apply via net accounts (affects SAM/LSA)
net accounts /lockoutthreshold:$lockoutThreshold

Write-Output "WN11-AC-000010 remediated: Account lockout threshold set to $lockoutThreshold invalid logon attempts."
