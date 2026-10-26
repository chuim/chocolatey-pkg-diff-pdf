[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$WhatIf
)

Set-Location $PSScriptRoot

if ($Force) { $global:au_Force = $true }
if ($WhatIf) { $global:au_WhatIf = $true }

Import-Module Chocolatey-AU

function global:au_GetLatest {
    $headers = @{}
    if ($env:GITHUB_TOKEN) {
        $headers['Authorization'] = "Bearer $env:GITHUB_TOKEN"
    }

    $LatestRelease = Invoke-RestMethod -Headers $headers -Uri 'https://api.github.com/repos/vslavik/diff-pdf/releases/latest'

    $Asset = $LatestRelease.assets | Where-Object { $_.name -like 'diff-pdf-win-*.zip' }
    if (!$Asset) {
        throw "No Windows ZIP asset matching 'diff-pdf-win-*.zip' found in release $($LatestRelease.tag_name)."
    }

    return @{
        Version      = $LatestRelease.tag_name.TrimStart('v')
        URL64        = $Asset.browser_download_url
        ReleaseNotes = $LatestRelease.html_url
    }
}

function global:au_SearchReplace {
    @{
        "tools\chocolateyinstall.ps1" = @{
            "(?i)(^\s*url\s*=\s*)('.*')"          = "`$1'$($Latest.URL64)'"
            "(?i)(^\s*checksum\s*=\s*)('.*')"     = "`$1'$($Latest.Checksum64)'"
            "(?i)(^\s*checksumType\s*=\s*)('.*')" = "`$1'$($Latest.ChecksumType64)'"
        }
    }
}

$package = Update-Package -ChecksumFor 64
if ($package -and $package.Updated) {
    $package.NuspecVersion = $package.RemoteVersion
}
return $package

