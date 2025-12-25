<#
.SYNOPSIS
    This PowerShell script ensures that users cannot bypass Windows Defender SmartScreen warnings in Microsoft Edge, preventing access to malicious websites.

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
# STIG ID: WN10-CC-000252
# Title  : Disable Windows Game Recording and Broadcasting
# Purpose: Prevent users from recording or broadcasting gameplay
# ============================================================

# Ensure script is running as Administrator
If (-NOT ([Security.Principal.WindowsPrincipal] `
    [Security.Principal.WindowsIdentity]::GetCurrent()
    ).IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)) {
    Write-Error "This script must be run as Administrator."
    Exit 1
}

# Registry path to disable Xbox Game Bar and related features
$GameDVRPaths = @(
    "HKLM:\SOFTWARE\Policies\Microsoft\Windows\GameDVR",
    "HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\GameDVR"
)

foreach ($path in $GameDVRPaths) {
    if (-not (Test-Path $path)) {
        New-Item -Path $path -Force | Out-Null
    }

    # Disable Game DVR and Game Bar
    New-ItemProperty -Path $path -Name "AllowGameDVR" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path $path -Name "AppCaptureEnabled" -PropertyType DWord -Value 0 -Force | Out-Null
    New-ItemProperty -Path $path -Name "GameDVR_Enabled" -PropertyType DWord -Value 0 -Force | Out-Null
}

Write-Output "Windows Game Recording and Broadcasting disabled via registry."

# Optional: Verify settings
foreach ($path in $GameDVRPaths) {
    $props = Get-ItemProperty -Path $path -ErrorAction SilentlyContinue
    if ($props) {
        Write-Output "Path: $path"
        Write-Output "AllowGameDVR: $($props.AllowGameDVR)"
        Write-Output "AppCaptureEnabled: $($props.AppCaptureEnabled)"
        Write-Output "GameDVR_Enabled: $($props.GameDVR_Enabled)"
    }
}
