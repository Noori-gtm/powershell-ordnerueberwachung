$pfad = "HIER_DEINEN_ORDNERPFAD_EINTRAGEN"
$ziel = "$pfad\Textdateien"

ni -ItemType Directory -Path $ziel -Force | Out-Null

while ($true) {
    $dateien = dir -Path $pfad -Filter "*.txt" -File

    foreach ($datei in $dateien) {
        $name = $datei.Name

        if ($name -eq "log.txt") {
            continue
        }

        if (Test-Path -LiteralPath "$ziel\$name") {
            continue
        }

        mv -LiteralPath $datei.FullName -Destination $ziel

        $datum = Get-Date -Format "dd.MM.yyyy HH:mm:ss"
        ac -Path "$pfad\log.txt" -Value "$datum - $name"
    }

    sleep -Seconds 5
}
