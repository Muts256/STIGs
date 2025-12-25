<#
.SYNOPSIS
    This PowerShell script ensures Account Lockout Duration to 15 minutes on a Windows 10 system.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
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
# STIG ID: WN10-AC-000005
# Title  : Account lockout duration must be 15 minutes or greater
# Purpose: Prevent rapid brute-force authentication attempts
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Set account lockout duration to 15 minutes
# This also requires an account lockout threshold to be configured
net accounts /lockoutduration:15

Write-Output "Account lockout duration set to 15 minutes (WN10-AC-000005 compliant)."
