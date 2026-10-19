# ZAIN.NET Wedding Invitation Showroom V1.0

Website katalog undangan mobile-first, siap GitHub Pages. Termasuk galeri, pencarian, kategori, favorit, animasi simulasi buka/tutup, suara sintetis kertas, detail produk, WhatsApp, dan panel admin upload/edit/hapus.

## A. Publikasi ke GitHub Pages
1. Ekstrak ZIP ini.
2. Buat repository GitHub baru (misalnya `katalog-undangan`).
3. Upload **seluruh isi folder** (index.html, app.js, config.js, manifest.webmanifest, assets/, dan file lainnya) ke root repository.
4. Buka **Settings > Pages > Build and deployment > Deploy from a branch**.
5. Pilih branch `main` dan folder `/(root)`, lalu Save.
6. Buka alamat `https://USERNAME.github.io/katalog-undangan/` setelah deployment selesai.

## B. Agar upload admin terlihat oleh seluruh pelanggan (WAJIB Supabase)
1. Buat proyek di https://supabase.com.
2. Buka SQL Editor dan jalankan isi `supabase.sql`.
3. Di Authentication > Users, buat satu akun admin dengan email dan password yang kuat (jangan aktifkan registrasi publik jika tidak diperlukan).
4. Salin **User UID** akun admin dari Authentication > Users.
5. Jalankan SQL berikut dengan UID asli:
   `insert into public.admins(user_id) values ('UID-AKUN-ADMIN');`
6. Buka Project Settings > API (atau Connect) dan ambil Project URL serta **anon/publishable key**.
7. Isi `SUPABASE_URL`, `SUPABASE_ANON_KEY`, dan `WHATSAPP_NUMBER` dalam `config.js` lalu commit perubahan ke GitHub.
8. Buka website > Admin > masuk menggunakan akun Supabase tadi > tambah model > upload foto > simpan.

**Keamanan:** Hanya gunakan anon/publishable key di `config.js`. JANGAN masukkan service_role/secret key ke GitHub. SQL mengaktifkan Row Level Security untuk operasi admin.

## C. Mode demo lokal
Jika Supabase belum dikonfigurasi, panel admin menggunakan localStorage. Data dan foto hanya terlihat di browser yang sama, tidak tersinkron ke perangkat pelanggan. Mode ini hanya untuk percobaan. Foto besar dapat memenuhi kuota localStorage.

## D. Catatan fitur
- Animasi buka/tutup merupakan **simulasi CSS**, bukan model 3D fisik yang presisi. Foto dalam yang berbeda harus diunggah untuk menampilkan isi yang benar.
- Mode lipat tiga dan 360° fisik belum tersedia pada versi ini; jenis lipatan tersimpan sebagai metadata.
- Efek suara adalah audio sintetis dari browser, bukan rekaman kertas asli.
- Dua produk awal memakai foto contoh yang diberikan pengguna; sebelum dipublikasikan, ganti foto dan metadata sesuai produk nyata.
- Harga, WhatsApp, dan spesifikasi produk tidak diisi secara fiktif.
