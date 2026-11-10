# KUR.ps1 tarafindan eklenen iki PDF baglam menusu secenegini kaldirir.
# Baskalarina ait menulere dokunmaz.
$ErrorActionPreference = 'Stop'
$base = 'HKCU:\Software\Classes\SystemFileAssociations\.pdf\shell'
$names = @('OpenSourcePdfQuickPrint', 'OpenSourcePdfPrintDialog')

foreach ($name in $names) {
    $key = "$base\$name"
    if (-not (Test-Path -LiteralPath $key)) {
        Write-Host "Mevcut degil: $name"
        continue
    }
    $marker = (Get-ItemProperty -Path $key -Name 'PdfQuickPrintProject' -ErrorAction SilentlyContinue).PdfQuickPrintProject
    if ($marker -ne '1') {
        Write-Warning "Bize ait oldugu dogrulanamadi; dokunulmadi: $name"
        continue
    }
    Remove-Item -LiteralPath $key -Recurse -Force
    Write-Host "Kaldirildi: $name"
}
Write-Host 'Tamamlandi. Vivaldi ve SumatraPDF silinmedi.'
