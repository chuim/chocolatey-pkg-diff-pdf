# Steps to update this package to a new diff-pdf version

Mostly as a reminder to myself...

1. Open the
[diff-pdf releases page](https://github.com/vslavik/diff-pdf/releases) to copy
the needed latest release URL and version number.
1. Download the latest release ZIP file and compute its SHA256 hash.
1. Update `tools\chocolateyinstall.ps1` to point to the latest release ZIP file
   URL and update the checksum with the SHA256 hash.
1. Update `diff-pdf.nuspec` with the latest release version number.
1. Open a command shell on this project's directory.
1. Run `choco pack` to create/update the `*.nupkg` file for the new version. 
1. Run `choco install diff-pdf --debug --verbose --source .` to test installing
   the new version.
   * You may need a shell with elevated privileges for this step.
   * If diff-pdf is already installed, add the `-f` option to force a reinstall
     or `choco upgrade...` instead with the same arguments.
1. If everything worked, push the new package:
   `choco push <new-package.nupkg> --source https://push.chocolatey.org/`
1. Commit and push changes and additions to the package repository.

References:
* https://docs.chocolatey.org/en-us/create/create-packages
* https://docs.chocolatey.org/en-us/create/create-packages-quick-start