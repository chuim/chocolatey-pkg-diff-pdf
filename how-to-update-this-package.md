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

## Local Testing and Usage

### Prerequisites
Install the `Chocolatey-AU` module (if not already installed):
```powershell
Install-Module -Name Chocolatey-AU -Scope CurrentUser
```

### Dry Run (Test without modifying files)
To check if a newer upstream version is available without modifying files:
```powershell
.\update.ps1 -WhatIf
```

### Force an Update Test
To simulate/force the entire update flow (downloads upstream asset, computes SHA256 checksum, updates install script, and creates the `.nupkg`) in dry-run mode:
```powershell
.\update.ps1 -Force -WhatIf
```

### Run an Actual Local Update
To perform an update locally:
```powershell
.\update.ps1
```
If an update is found:
1. `diff-pdf\diff-pdf.nuspec` is updated with the new version.
2. `diff-pdf\tools\chocolateyinstall.ps1` is updated with the new URL and SHA256 checksum.
3. The new `diff-pdf.<version>.nupkg` is built in `diff-pdf\`.

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
