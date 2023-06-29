if (Test-Path artifacts) {
    Remove-Item -Recurse -Force artifacts
}
New-Item -ItemType Directory -Path artifacts | Out-Null
Copy-Item -Recurse build/web -Destination artifacts
