<#
.SYNOPSIS
    This PowerShell script ensures that users cannot bypass Windows Defender SmartScreen warnings in Microsoft Edge, preventing access to malicious websites.

.NOTES
    Author          : Michael Musoke
    LinkedIn        : https://www.linkedin.com/in/michael-musoke/
    GitHub          : https://github.com/Muts256
    Date Created    : 2025-12-25
    Last Modified   : 2024-12-25
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
# STIG ID: WN10-CC-000230
# Title  : Prevent bypassing Windows Defender SmartScreen prompts for sites
# Purpose: Enforce SmartScreen warnings so users cannot ignore them
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry paths for SmartScreen policy (both possible locations)
$regPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\MicrosoftEdge\PhishingFilter",
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows Defender SmartScreen\MicrosoftEdge"
)

# Apply the policy to prevent bypassing SmartScreen warnings
foreach ($path in $regPaths) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    # Value: 1 = Enabled, 0 = Disabled
    New-ItemProperty -Path $path -Name "PreventOverride" -PropertyType DWord -Value 1 -Force | Out-Null
    Write-Output "SmartScreen PreventOverride enabled at: $path"
}

# Optional: Verify settings
foreach ($path in $regPaths) {
    $setting = Get-ItemProperty -Path $path -Name "PreventOverride" -ErrorAction SilentlyContinue
    if ($setting) {
        Write-Output "$path : PreventOverride = $($setting.PreventOverride)"
    }
}
