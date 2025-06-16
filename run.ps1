$pico8 = "G:\Program Files\Pico8\Pico-8\pico8.exe"

$project = "game.p8"

if (-Not (Test-Path $pico8)) {
    Write-Host "❌ Не найден pico8.exe по пути: $pico8"
    exit
}

& $pico8 -run $project
