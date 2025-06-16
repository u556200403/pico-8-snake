$pico8 = "G:\Program Files\Pico8\Pico-8\pico8.exe"
$project = "game.p8"
$output = "game.html"

if (-Not (Test-Path $pico8)) {
    Write-Host "❌ Не найден pico8.exe по пути: $pico8"
    exit
}

Write-Host "▶️ Запуск..."
& $pico8 $project

Write-Host "📤 Экспорт в HTML..."
& $pico8 -export $output $project

Write-Host "✅ Экспорт завершён: $output"
