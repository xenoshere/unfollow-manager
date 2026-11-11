# Unfollow Manager — GitHub Pages + Supabase

## Fitur
- Login email/password dan Google OAuth (Google perlu diaktifkan di Supabase).
- Impor followers JSON + following JSON dari ekspor Instagram.
- Deteksi akun following yang tidak ada di followers.
- Klik "Buka IG" membuka profil di tab baru.
- Saat diklik, akun otomatis dicoret dan dipindah ke bawah.
- Data dan progres tersimpan lintas sesi/perangkat melalui Supabase.
- Undo terakhir.

## Penting
Status "Dikunjungi" hanya berarti profil dibuka dari website. Website tidak dapat memastikan akun benar-benar di-unfollow dan tidak melakukan unfollow otomatis.

## Setup Supabase
1. Buat project di https://supabase.com
2. Buka SQL Editor, jalankan seluruh isi `supabase-schema.sql`.
3. Buka Project Settings > API, salin Project URL dan anon/public key.
4. Edit `index.html`, ganti:
   - `PASTE_SUPABASE_PROJECT_URL_HERE`
   - `PASTE_SUPABASE_ANON_KEY_HERE`
5. Authentication > URL Configuration:
   - Site URL: URL GitHub Pages kamu.
   - Tambahkan URL GitHub Pages ke Redirect URLs.
6. Authentication > Providers > Google: aktifkan Google dan masukkan OAuth Client ID/Secret dari Google Cloud.
7. Untuk email/password, atur Email provider dan konfirmasi email sesuai kebutuhan.

## Publish ke GitHub Pages
1. Buat repository GitHub baru.
2. Upload `index.html` dan `supabase-schema.sql` (README boleh ikut).
3. Repository Settings > Pages.
4. Build and deployment: Deploy from a branch.
5. Pilih branch `main`, folder `/ (root)`, lalu Save.
6. Masukkan URL GitHub Pages ke Supabase Redirect URLs dan Site URL.

## Struktur
- `index.html` — website.
- `supabase-schema.sql` — tabel dan aturan akses database.

## Catatan format JSON
Pilih kedua file sekaligus. Nama file perlu mengandung kata `follower` dan `following` (contoh `followers_1.json` dan `following.json`). Parser membaca struktur ekspor Instagram yang memakai `string_list_data`.
