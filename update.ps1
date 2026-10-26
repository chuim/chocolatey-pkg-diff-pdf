[CmdletBinding()]
param(
    [switch]$Force,
    [switch]$WhatIf
)

Push-Location "$PSScriptRoot\diff-pdf"
try {
    & .\update.ps1 @PSBoundParameters
} finally {
    Pop-Location
}

