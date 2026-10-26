$ErrorActionPreference = 'Stop';
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $env:ChocolateyPackageName
  unzipLocation = $toolsDir
  url           = 'https://github.com/vslavik/diff-pdf/releases/download/v0.5.3/diff-pdf-win-0.5.3.zip'
  checksum      = '31c6dd5472f3d83b4a6023cf929b475ded04ba5fa24b2d027fae3a3098b169ea'
  checksumType  = 'sha256'
}

Install-ChocolateyZipPackage @packageArgs
