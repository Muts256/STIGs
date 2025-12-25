<#
.SYNOPSIS
    This PowerShell script configures the SMB server always digitally signs communications, preventing tampering or man-in-the-middle attacks..

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-SO-000120

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-CC-000120).ps1 
#>
# ============================================================
# STIG ID: WN10-SO-000120
# Title  : Require SMB signing on Windows SMB server
# Purpose: Ensure all SMB communications are digitally signed
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path for SMB server parameters
$RegPath = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanServer\Parameters"

# Enable SMB server signing
New-ItemProperty -Path $RegPath -Name "RequireSecuritySignature" -PropertyType DWord -Value 1 -Force | Out-Null

Write-Output "WN10-SO-000120 remediation applied: SMB server now requires signed communications."

# Optional: Verify setting
$verify = Get-ItemProperty -Path $RegPath -Name "RequireSecuritySignature"
Write-Output "RequireSecuritySignature: $($verify.RequireSecuritySignature)"

# Inform user
Write-Output "A reboot may be required for the SMB signing setting to take full effect."
