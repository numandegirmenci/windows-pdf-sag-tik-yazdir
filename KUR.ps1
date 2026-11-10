# PDF'lere sag tikla > Yazdir secenegi ekler.
# Kullanici profiline (HKCU) yazar; yonetici izni istemez.
# Varsayilan PDF goruntuleyicisini degistirmez.
$ErrorActionPreference = 'Stop'

Add-Type -AssemblyName System.Windows.Forms
$dialog = New-Object System.Windows.Forms.OpenFileDialog
$dialog.Title = 'SumatraPDF Portable uygulamasini secin'
$dialog.Filter = 'SumatraPDF uygulamasi (SumatraPDF*.exe)|SumatraPDF*.exe|Uygulamalar (*.exe)|*.exe'
$dialog.CheckFileExists = $true

if ($dialog.ShowDialog() -ne [System.Windows.Forms.DialogResult]::OK) {
    Write-Host 'Islem iptal edildi. Herhangi bir ayar degistirilmedi.'
    return
}

$exe = (Resolve-Path -LiteralPath $dialog.FileName).ProviderPath
if ((Split-Path -Path $exe -Leaf) -notmatch '^SumatraPDF[^\\/]*\.exe$') {
    throw 'Secilen dosya SumatraPDF uygulamasi gibi gorunmuyor. Islem yapilmadi.'
}

$base = 'HKCU:\Software\Classes\SystemFileAssociations\.pdf\shell'
$entries = @(
    @{ Key = 'OpenSourcePdfQuickPrint'; Label = 'Yazdir (Varsayilan Yazici)'; Args = '-print-to-default' },
    @{ Key = 'OpenSourcePdfPrintDialog'; Label = 'Yazdir (Yazici Sec)'; Args = '-print-dialog -exit-when-done' }
)

# Baskasinin mevcut baglam menusu komutlarini degistirmeyelim.
foreach ($entry in $entries) {
    $key = "$base\$($entry.Key)"
    if (Test-Path -LiteralPath $key) {
        throw "Bu secenek zaten mevcut: $key. Mevcut ayarlar degistirilmedi."
    }
}

foreach ($entry in $entries) {
    $key = "$base\$($entry.Key)"
    New-Item -Path "$key\command" -Force | Out-Null
    Set-Item -Path $key -Value $entry.Label
    New-ItemProperty -Path $key -Name 'MultiSelectModel' -PropertyType String -Value 'Document' -Force | Out-Null
    New-ItemProperty -Path $key -Name 'PdfQuickPrintProject' -PropertyType String -Value '1' -Force | Out-Null
    $command = '"' + $exe + '" ' + $entry.Args + ' "%1"'
    Set-Item -Path "$key\command" -Value $command
}

Write-Host ''
Write-Host 'Tamamlandi! PDF dosyasina sag tiklayin.' -ForegroundColor Green
Write-Host 'Windows 11 icin gerekirse: Diger secenekleri goster.'
Write-Host 'PDF varsayilan uygulamaniz degistirilmedi.'
Write-Host 'NOT: SumatraPDF.exe dosyasini sonradan tasimayin.'
