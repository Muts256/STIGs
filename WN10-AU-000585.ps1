<#
.SYNOPSIS
    enables failure auditing for process creation to detect unsuccessful attempts to execute commands or processes, providing visibility into potentially malicious activity.
.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2025-12-25
    Version         : 1.0
    CVEs            : N/A
    Plugin IDs      : N/A
    STIG-ID         : WN10-AU-000585

.TESTED ON
    Date(s) Tested  : 
    Tested By       : 
    Systems Tested  : 
    PowerShell Ver. : 

.USAGE
    Put any usage instructions here.
    Example syntax:
    PS C:\> .\__remediation_template(STIG ID: WN10-AU-000585).ps1 
#>
# ========================================================================================================
# STIG ID: WN10-AU-000585
# Title: Enable failure auditing for Process Creation (Permanent)
# Purpose:
#   1. Force Advanced Audit Policy to override legacy audit policy
#   2. Enable failure auditing for Process Creation
#   3. Verify effective configuration
#
# NOTE:
#   A system reboot is REQUIRED after this script runs for the setting to persist and pass Nessus/STIG scans.
# ============================================================================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

Write-Output "Starting WN10-AU-000585 remediation..."

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
# Step 2: Enable failure auditing for Process Creation
# ------------------------------------------------------------
$subcategory = "Process Creation"

AuditPol.exe /set /subcategory:"$subcategory" /success:disable /failure:enable

Write-Output "Failure auditing enabled for Process Creation."

# ------------------------------------------------------------
# Step 3: Verify configuration
# ------------------------------------------------------------
Write-Output "Verifying audit policy..."
AuditPol.exe /get /subcategory:"$subcategory"

Write-Output "WN10-AU-000585 remediation applied."
Write-Output "IMPORTANT: A system reboot is required for this setting to persist."
