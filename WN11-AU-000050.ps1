<#
.SYNOPSIS
    This PowerShell script sets Audit Detailed Tracking - Process Creation (Success).

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-26
    Last Modified   : 2025-12-26
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
# STIG ID: WN11-AU-000050
# Title : Audit Detailed Tracking - Process Creation (Success)
# Purpose:
#   1. Force Advanced Audit Policy to override legacy audit policy
#   2. Enable success auditing for Process Creation
#   3. Verify effective configuration
#
# NOTE:
#   A reboot is REQUIRED for persistence and Nessus compliance.
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Output "Starting WN11-AU-000050 remediation..."

# ------------------------------------------------------------
# Step 1: Force Advanced Audit Policy to override legacy policy
# ------------------------------------------------------------
$lsaRegPath = "HKLM:\SYSTEM\CurrentControlSet\Control\Lsa"
$lsaRegName = "SCENoApplyLegacyAuditPolicy"

New-ItemProperty `
    -Path $lsaRegPath `
    -Name $lsaRegName `
    -PropertyType DWord `
    -Value 1 `
    -Force | Out-Null

Write-Output "Advanced Audit Policy override enabled."

# ------------------------------------------------------------
# Step 2: Enable SUCCESS auditing for Process Creation
# ------------------------------------------------------------
$subcategory = "Process Creation"

AuditPol.exe /set /subcategory:"$subcategory" /success:enable /failure:disable

Write-Output "Success auditing enabled for Process Creation."

# ------------------------------------------------------------
# Step 3: Verify configuration
# ------------------------------------------------------------
Write-Output "Verifying audit policy..."
AuditPol.exe /get /subcategory:"$subcategory"

Write-Output "WN11-AU-000050 remediation applied."
Write-Output "IMPORTANT: Reboot the system to ensure persistence and Nessus compliance."
