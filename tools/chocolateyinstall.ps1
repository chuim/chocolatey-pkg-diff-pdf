$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/vslavik/diff-pdf/releases/download/v0.5.1/diff-pdf-win-0.5.1.zip'
  checksum      = '996bd1c10162846109c01a1af924d7229c0ea315407f97674daafb3c97931e06'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs