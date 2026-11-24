#Requires -Version 5.1
# Downloads the cfu binary of a Confµgami release from vehub into the current working directory.
$ErrorActionPreference = 'Stop'
$ProgressPreference = 'SilentlyContinue'

$mavenUrl = 'https://packages.vehub.vector.com/maven/com/vector/confugami/cfu'
$target = 'x86_64-pc-windows-msvc'

function Show-Usage {
    @'
Usage: install.ps1 [--version <version>] [--pin]

  --version <version>  Install this version instead of the latest release (with or without the leading 'v').
  --pin                Write a .confu next to the binary that disables the auto update.
'@
}

$version = ''
$pin = $false
for ($i = 0; $i -lt $args.Count; $i++) {
    switch -Regex ($args[$i]) {
        '^--?version$' {
            $version = $args[++$i]
            if (-not $version) { throw '--version needs a value.' }
        }
        '^--?pin$' { $pin = $true }
        '^(-h|--help|-\?)$' { Show-Usage; return }
        default { Show-Usage; throw "Unknown option: $($args[$i])" }
    }
}

if (-not $version) {
    # vehub serves the metadata as application/octet-stream, which Windows PowerShell 5.1 hands
    # back as bytes from Invoke-WebRequest, so WebClient reads it as text.
    $metadata = [xml](New-Object System.Net.WebClient).DownloadString("$mavenUrl/maven-metadata.xml")
    $version = $metadata.metadata.versioning.release
    if (-not $version) { throw 'Could not resolve the latest release, pass --version.' }
}
$version = $version -replace '^v', ''

$dist = "confugami-$version-$target"
$tmp = New-Item -ItemType Directory -Path (Join-Path $env:TEMP ([guid]::NewGuid()))
try {
    $zip = Join-Path $tmp "$dist.zip"
    $asset = "cfu-$version-$target.zip"
    Write-Host "Downloading $asset"
    Invoke-WebRequest -Uri "$mavenUrl/$version/$asset" -OutFile $zip -UseBasicParsing
    Expand-Archive -Path $zip -DestinationPath $tmp -Force
    Copy-Item -Path (Join-Path $tmp "$dist\cfu.exe") -Destination (Join-Path (Get-Location) 'cfu.exe') -Force
} finally {
    Remove-Item -Path $tmp -Recurse -Force
}

if ($pin) {
    if (Test-Path '.confu') {
        Write-Warning ".confu exists, left untouched. Add 'executableSettings: { autoUpdate: false }' yourself."
    } else {
        @'
{
  executableSettings: {
    autoUpdate: false,
  },
}
'@ | Set-Content -Path '.confu' -Encoding UTF8
        Write-Host 'Wrote .confu with autoUpdate disabled.'
    }
}

Write-Host "Installed cfu.exe $version to $(Get-Location)"
