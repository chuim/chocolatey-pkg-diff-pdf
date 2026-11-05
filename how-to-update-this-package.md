# Updating the diff-pdf Chocolatey Package

This package is automated using [Chocolatey-AU](https://github.com/chocolatey-community/chocolatey-au).

## Directory Structure

```text
chocolatey-pkg-diff-pdf/
├── .github/
│   └── workflows/
│       └── update-package.yml   # Scheduled GitHub Actions workflow
├── diff-pdf/                    # Package folder (must match package ID for AU)
│   ├── diff-pdf.nuspec          # Package manifest
│   ├── update.ps1               # AU update script
│   └── tools/
│       └── chocolateyinstall.ps1
├── update.ps1                   # Root wrapper script
├── how-to-update-this-package.md
└── README.md
```

## GitHub Actions Automation

The package checks for updates automatically every day via GitHub Actions.

### Setup Checklist

1. **Chocolatey API Key**: Get your API key from [community.chocolatey.org/account](https://community.chocolatey.org/account).
2. **GitHub Repository Secret**:
   - In GitHub, go to **Settings** > **Secrets and variables** > **Actions**.
   - Create a repository secret named `CHOCO_API_KEY` with your API key.
3. **Workflow Permissions**:
   - Go to **Settings** > **Actions** > **General**.
   - Under **Workflow permissions**, make sure **Read and write permissions** is selected (allows the workflow to commit version bumps back to git).
4. **Trigger Manually**:
   - Go to the **Actions** tab on GitHub, select **Auto Update Package**, and click **Run workflow**.

### Keeping the Schedule Running

GitHub disables scheduled workflows in public repositories after 60 days without repository activity, and diff-pdf releases can be further apart than that. If it happens, re-enable the workflow from the **Actions** tab, then run it once to pick up any release it missed.

## Local Testing and Usage

### Prerequisites
Install the `Chocolatey-AU` module (if not already installed):
```powershell
Install-Module -Name Chocolatey-AU -Scope CurrentUser
```

### Run a Local Update
Run these in Windows PowerShell. Nothing gets pushed.
```powershell
.\update.ps1          # Update the package files and build the nupkg, if there's a new release
.\update.ps1 -Force   # Same, even if there's no new release
```
If an update is found:
1. `diff-pdf\diff-pdf.nuspec` is updated with the new version.
2. `diff-pdf\tools\chocolateyinstall.ps1` is updated with the new URL and SHA256 checksum.
3. The new `diff-pdf.<version>.nupkg` is built in `diff-pdf\`.

With `-Force` and no new release, the version gets a date suffix (for example `0.5.3.20261104`).

To undo the changes to the package files, run `git restore .`.

### Test Installing the Generated Package Locally
```powershell
choco install diff-pdf --source ./diff-pdf --force
```

### Manual Push (if needed)
```powershell
choco push .\diff-pdf\diff-pdf.<version>.nupkg --source https://push.chocolatey.org/
```

## References
* [Chocolatey Automatic Packaging (AU)](https://github.com/chocolatey-community/chocolatey-au)
* [Chocolatey AU Action](https://github.com/chocolatey-community/chocolatey-au-action)
* [diff-pdf Releases](https://github.com/vslavik/diff-pdf/releases)
