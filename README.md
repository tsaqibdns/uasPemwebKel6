# LANGKAH DAN CARA INSTALASI WEB RUMAH LAUNDRY

1. Setelah mengunduh file, ekstrak file zip yang sudah didownload ke dalam satu folder dan beri nama `rumah_laundry_6`.
2. Salin atau pindahkan folder `rumah_laundry_6` ke dalam `xampp/htdocs/`.

## Langkah Instalasi

1. Aktifkan web server (bisa menggunakan LAMP, XAMPP, WAMPP, dll), lalu aktifkan Apache dan MySQL.
2. Buka web browser dan akses `localhost/phpmyadmin`.
3. Buat database baru dengan nama `laundry_app`.
4. Setelah database dibuat, klik database `laundry_app`.
5. Import file SQL dengan klik menu/tab **Impor** di bagian atas phpMyAdmin.
6. Klik **Choose file**, cari file `laundry_app.sql` yang sudah disediakan, lalu klik tombol **Kirim/Go** (scroll ke bawah jika perlu).
7. Buka tab baru di web browser, lalu akses `localhost/rumah_laundry_6/`.
8. Login dengan:
   - **Username:** admin
   - **Password:** admin
