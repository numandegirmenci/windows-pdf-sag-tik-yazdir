# Windows'ta PDF'lere Sağ Tıkla → Yazdır

PDF dosyaları **Vivaldi ile açılmaya devam ederken** Windows Dosya Gezgini'ndeki sağ tık menüsüne iki yazdırma komutu ekleyen küçük ve ücretsiz PowerShell aracı.

- **Yazdır (Varsayılan Yazıcı):** Dosyayı doğrudan varsayılan yazıcıya gönderir; önizleme göstermez.
- **Yazdır (Yazıcı Seç):** SumatraPDF'nin yazdırma penceresini açar.
- PDF'nin varsayılan uygulamasını değiştirmez.
- Kayıt defteri değişiklikleri yalnızca oturum açmış **kullanıcının hesabında (HKCU)** yapılır; çoğu ortamda yönetici izni gerekmez.
- **KALDIR.ps1** ile bu aracın eklediği iki komut geri alınabilir.

## Gerekenler

- Windows 10 veya 11 ve Windows PowerShell 5.1+.
- [SumatraPDF Portable](https://www.sumatrapdfreader.org/download-free-pdf-viewer) (bu projeye dahil değildir).
- Kurum bilgisayarlarında kuruluşun güvenlik ve yazılım politikalarına uyulmalıdır.

## Kurulum

1. Depoyu ZIP olarak indirip klasöre çıkar.
2. SumatraPDF'nin **taşınabilir** `.exe` dosyasını kalıcı bir klasöre yerleştir. Dosyayı sonradan taşırsan yazdırma menüsü çalışmayabilir.
3. PowerShell'i normal kullanıcı olarak aç ve projenin klasörüne geç.
4. `./KUR.ps1` komutunu çalıştır. Pencere açılınca **SumatraPDF.exe** dosyasını seç.
5. Bir PDF'ye sağ tıkla; Windows 11'de gerekirse **Diğer seçenekleri göster** menüsüne bak.

PowerShell betik çalıştırmayı engelliyorsa kurumun güvenlik politikasını aşmak yerine BT ekibinden izin isteyin.

## Kaldırma

PowerShell'de bu klasördeyken `./KALDIR.ps1` komutunu çalıştır. Yalnızca bu araç tarafından oluşturulmuş, işaretlenmiş iki bağlam menüsü girdisi kaldırılır.

## Önemli notlar

- Birden fazla PDF seçildiğinde yazdırma komutu birden fazla kez çalışabilir. Önce 1–2 **önemsiz** PDF ile dene.
- Windows çok sayıda dosya seçildiğinde bazı sağ tık menülerini gizleyebilir (varsayılan eşik 15). Bu araç o Windows sınırını değiştirmez.
- **Doğrudan yazdırma** varsayılan yazıcıya gönderir; yanlış yazıcı seçiliyse yanlış yerde çıktı alınabilir.
- Bu proje SumatraPDF ile ilişkili değildir; SumatraPDF uygulamasını veya başka bir üçüncü tarafın dosyalarını dağıtmaz.
- Microsoft PowerShell üzerinden kayıt defteri değişikliği yapar: `HKCU\Software\Classes\SystemFileAssociations\.pdf\shell`.

## Lisans

MIT Lisansı. [LICENSE](LICENSE) dosyasına bakın.
