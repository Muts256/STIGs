<#
.SYNOPSIS
    This PowerShell script enforces SMB packet signing on Windows 10 clients to protect file-share communications from tampering and man-in-the-middle attacks.
    
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

# ============================================================
# STIG ID: WN10-SO-000100
# Title  : Enforce SMB packet signing (RequireSecuritySignature)
# Purpose: Protect SMB communications from tampering and MITM attacks
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path for SMB client (LanmanWorkstation)
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"

# Create key if it doesn't exist
If (-Not (Test-Path $RegPath)) {
    New-Item -Path $RegPath -Force | Out-Null
}

# Set RequireSecuritySignature = 1 (enforce SMB signing)
New-ItemProperty `
    -Path $RegPath `
    -Name "RequireSecuritySignature" `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

Write-Output "WN10-SO-000100 remediation applied: SMB packet signing is now enforced."

# Optional: verify the setting
$setting = Get-ItemProperty -Path $RegPath -Name "RequireSecuritySignature"
Write-Output "Current RequireSecuritySignature value: $($setting.RequireSecuritySignature)"
