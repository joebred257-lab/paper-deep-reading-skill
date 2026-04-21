[CmdletBinding()]
param(
    [switch]$SkipPythonDeps,
    [switch]$InstallOptionalOcrDeps,
    [switch]$Force
)

$ErrorActionPreference = 'Stop'

function Get-PythonCommand {
    if (Get-Command python -ErrorAction SilentlyContinue) {
        return @{
            Exe  = 'python'
            Args = @()
        }
    }

    if (Get-Command py -ErrorAction SilentlyContinue) {
        return @{
            Exe  = 'py'
            Args = @('-3')
        }
    }

    throw 'Python 3 was not found. Install Python 3.10+ first.'
}

function Ensure-Directory([string]$PathValue) {
    if (-not (Test-Path -LiteralPath $PathValue)) {
        New-Item -ItemType Directory -Path $PathValue -Force | Out-Null
    }
}

$repoRoot = Split-Path -Parent $MyInvocation.MyCommand.Path
$sourceDir = Join-Path $repoRoot 'paper-deep-reading'

if (-not (Test-Path -LiteralPath $sourceDir)) {
    throw "Skill folder not found: $sourceDir"
}

$skillsRoot = if ($env:CODEX_HOME) {
    Join-Path $env:CODEX_HOME 'skills'
} else {
    Join-Path $HOME '.codex\skills'
}

$targetDir = Join-Path $skillsRoot 'paper-deep-reading'

Ensure-Directory $skillsRoot

if (Test-Path -LiteralPath $targetDir) {
    if ($Force) {
        Remove-Item -LiteralPath $targetDir -Recurse -Force
    } else {
        $timestamp = Get-Date -Format 'yyyyMMdd-HHmmss'
        $backupDir = "$targetDir.backup-$timestamp"
        Copy-Item -LiteralPath $targetDir -Destination $backupDir -Recurse -Force
        Remove-Item -LiteralPath $targetDir -Recurse -Force
        Write-Host "Existing install backed up to: $backupDir"
    }
}

Copy-Item -LiteralPath $sourceDir -Destination $targetDir -Recurse -Force
Write-Host "Skill installed to: $targetDir"

$python = Get-PythonCommand

if (-not $SkipPythonDeps) {
    Write-Host 'Installing required Python packages: pymupdf, pillow'
    & $python.Exe @($python.Args + @('-m', 'pip', 'install', '--upgrade', 'pymupdf', 'pillow'))
    if ($LASTEXITCODE -ne 0) {
        throw 'Failed to install required Python dependencies.'
    }

    if ($InstallOptionalOcrDeps) {
        Write-Host 'Installing optional OCR Python package: pytesseract'
        & $python.Exe @($python.Args + @('-m', 'pip', 'install', '--upgrade', 'pytesseract'))
        if ($LASTEXITCODE -ne 0) {
            throw 'Failed to install optional OCR dependency.'
        }
    }
}

Write-Host 'Running a lightweight dependency smoke test...'
& $python.Exe @($python.Args + @('-c', 'import fitz; from PIL import Image; print(''paper_deep_reading_python_ok'')'))
if ($LASTEXITCODE -ne 0) {
    throw 'Python smoke test failed after installation.'
}

if (Get-Command codex -ErrorAction SilentlyContinue) {
    Write-Host 'Codex CLI detected. You can now call $paper-deep-reading in Codex.'
} else {
    Write-Warning 'Codex CLI was not found in PATH. Install it with: npm install -g @openai/codex'
    Write-Warning 'Then log in with: codex --login'
}

Write-Host ''
Write-Host 'Install complete.'
Write-Host "Installed skill path: $targetDir"
Write-Host 'If you need OCR for scanned PDFs, also install the Windows Tesseract OCR binary and rerun this script with -InstallOptionalOcrDeps.'
