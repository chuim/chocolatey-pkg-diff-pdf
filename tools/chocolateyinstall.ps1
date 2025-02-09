$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/vslavik/diff-pdf/releases/download/v0.5.2/diff-pdf-win-0.5.2.zip'
  checksum      = 'f72848b23f87ce9d9517e20ddbe30985a31caca1c725d38918df990c0acf48f9'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs