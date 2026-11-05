[CmdletBinding()]
param(
    [switch]$Force
)

Push-Location "$PSScriptRoot\diff-pdf"
try {
    & .\update.ps1 @PSBoundParameters
} finally {
    Pop-Location
}

