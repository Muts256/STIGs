<#
.SYNOPSIS
    This PowerShell script enforces a minimum password age of at least one day, preventing password cycling and ensuring the effectiveness of password history controls.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AC-000020

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-AC-000020).ps1 
#>
# ============================================================
# STIG ID: WN10-AC-000020
# Title  : Minimum password age must be at least 1 day
# Purpose: Prevent password cycling and reuse
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {

    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Set minimum password age to 1 day
net accounts /minpwage:1

Write-Output "Minimum password age set to 1 day (WN10-AC-000020 compliant)."
