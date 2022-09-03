$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/vslavik/diff-pdf/releases/download/v0.5/diff-pdf-win-0.5.zip'
  checksum      = 'b93b6f9b60f208b307b969dbdc22401275424f77e08edbafc33dd51bb5d556a2'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs