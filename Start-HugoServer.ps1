[CmdletBinding()]
param (
)

Push-Location -ErrorAction Stop

try {
    Set-Location -Path ./site/ -ErrorAction Stop

    hugo server --gc --themesDir ../../../themefisher/
}
finally {
    Pop-Location -ErrorAction Stop
}