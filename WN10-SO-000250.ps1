<#
.SYNOPSIS
    This PowerShell script ensures that UAC prompts administrators for consent on the secure desktop, preventing unauthorized privilege escalation.

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
# STIG ID: WN10-SO-000250
# Title  : UAC must prompt administrators on the secure desktop
# Purpose: Prevent unauthorized privilege escalation
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path for UAC settings
$RegPath = "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Policies\System"

# Enable UAC for admin consent on the secure desktop
# 2 = Prompt for consent on the secure desktop
New-ItemProperty -Path $RegPath -Name "ConsentPromptBehaviorAdmin" -PropertyType DWord -Value 2 -Force | Out-Null

# Ensure UAC is enabled
New-ItemProperty -Path $RegPath -Name "EnableLUA" -PropertyType DWord -Value 1 -Force | Out-Null

Write-Output "WN10-SO-000250 remediation applied: UAC will prompt administrators for consent on the secure desktop."

# Optional: Verify the settings
$verify = Get-ItemProperty -Path $RegPath
Write-Output "EnableLUA: $($verify.EnableLUA)"
Write-Output "ConsentPromptBehaviorAdmin: $($verify.ConsentPromptBehaviorAdmin)"
