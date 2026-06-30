# Perencanaan Views - Absensi PPKD B6

Dokumen ini berisi perencanaan struktur dan komponen *views/screens* untuk aplikasi Flutter berdasarkan *endpoints* yang tersedia pada *Postman Collection* dan *Services* Retrofit.

Lokasi folder *views*: `lib/tugas/tugas_flutter_15/views`

## 1. Autentikasi & Akun (Berdasarkan `auth_service.dart`)

### 1.1 Login View (`login_screen.dart`)
- **Tujuan:** Halaman untuk pengguna masuk ke dalam aplikasi.
- **Form Fields:**
  - `email` (TextFormField dengan validasi email)
  - `password` (TextFormField dengan *obscure text*)
- **Actions:** 
  - Tombol **Login**: Memanggil `AuthService.login()`.
  - Tautan ke **Register**: Navigasi ke `register_screen.dart`.

### 1.2 Register View (`register_screen.dart`)
- **Tujuan:** Halaman pendaftaran pengguna baru.
- **Form Fields:**
  - `name` (TextFormField)
  - `email` (TextFormField)
  - `password` (TextFormField)
  - `jenis_kelamin` (DropdownButton atau RadioButton: `L` / `P`)
  - `batch_id` (DropdownButton) -> Mengambil data dari `BatchService.getBatches()`
  - `training_id` (DropdownButton) -> Mengambil data dari `TrainingService.getTrainings()`
  - `profile_photo` (Image Picker / File Upload) -> Di-*encode* ke Base64 (opsional)
- **Actions:**
  - Tombol **Register**: Memanggil `AuthService.register()`.
  - Tautan ke **Login**: Navigasi ke `login_screen.dart`.

### 1.3 Profile View (`profile_screen.dart`)
- **Tujuan:** Menampilkan detail data pengguna yang sedang login.
- **Data yang Ditampilkan:** (Hasil dari `AuthService.getProfile()`)
  - Foto Profil (ditampilkan dari URL/Base64 jika ada)
  - Nama & Email
  - Jenis Kelamin
  - Detail Batch (Batch ke, Start Date, End Date)
  - Detail Training (Judul, Durasi, dll)
- **Actions:**
  - Tombol **Edit Profil**: Navigasi ke `edit_profile_screen.dart`.
  - Tombol **Ubah Foto Profil**: Membuka modal/halaman *image picker*.
  - Tombol **Logout**: Menghapus token dari *storage* dan kembali ke `login_screen.dart`.

### 1.4 Edit Profile View (`edit_profile_screen.dart`)
- **Tujuan:** Halaman untuk memperbarui nama (dan info dasar lainnya).
- **Form Fields:**
  - `name` (TextFormField, diisi *default* dengan nama saat ini)
- **Actions:**
  - Tombol **Simpan**: Memanggil `AuthService.updateProfile()`.

### 1.5 Image Picker Screen / Modal (`image_picker_screen.dart`)
- **Tujuan:** Mengambil foto dari Galeri atau Kamera untuk pembaruan *profile photo*.
- **Actions:**
  - Meng-*encode* foto ke format Base64 (`data:image/png;base64,...`).
  - Memanggil `AuthService.updateProfilePhoto()`.


## 2. Fitur Tambahan (Berdasarkan *Services* Lainnya)

Untuk mendukung endpoints `users`, `trainings`, dan `batches`, disarankan untuk membuat halaman-halaman berikut:

### 2.1 Home / Dashboard View (`home_screen.dart`)
- **Tujuan:** Halaman utama setelah berhasil login.
- **Komponen:**
  - *Greeting* menyambut nama pengguna.
  - Ringkasan fitur yang tersedia (Menu menuju Daftar Pengguna, Daftar Pelatihan, Profil).
  - *BottomNavigationBar* atau *Drawer* untuk navigasi menu utama.

### 2.2 Users List View (`users_screen.dart`)
- **Tujuan:** Menampilkan seluruh data pengguna terdaftar.
- **Komponen:**
  - `ListView.builder` menampilkan *list card* pengguna.
- **Data Source:** Memanggil `UserService.getUsers()`.

### 2.3 Trainings List View (`trainings_screen.dart`)
- **Tujuan:** Menampilkan daftar pelatihan yang tersedia (Publik).
- **Komponen:**
  - `ListView.builder` menampilkan judul pelatihan (`title`).
- **Data Source:** Memanggil `TrainingService.getTrainings()`.
- **Actions:** *Tap* pada *card* pelatihan akan menavigasikan ke `training_detail_screen.dart`.

### 2.4 Training Detail View (`training_detail_screen.dart`)
- **Tujuan:** Menampilkan detail dari satu pelatihan secara spesifik.
- **Data yang Ditampilkan:**
  - Title, Description, Participant Count, Standard, Duration.
  - Units & Activities (jika ada *array* datanya).
- **Data Source:** Memanggil `TrainingService.getTrainingDetail(id)`.

### 2.5 Batches List View (`batches_screen.dart` - Opsional)
- **Tujuan:** Menampilkan daftar batch / gelombang.
- **Komponen:**
  - Menampilkan `batch_ke`, `start_date`, dan `end_date`.
- **Data Source:** Memanggil `BatchService.getBatches()`.

---

## 3. Struktur Folder (*Routing* & *State Management*)
Saran pengelompokan folder di dalam `views`:
```text
views/
 ├── auth/
 │    ├── login_screen.dart
 │    └── register_screen.dart
 ├── profile/
 │    ├── profile_screen.dart
 │    ├── edit_profile_screen.dart
 │    └── image_picker_screen.dart
 ├── home/
 │    └── home_screen.dart
 ├── users/
 │    └── users_screen.dart
 ├── trainings/
 │    ├── trainings_screen.dart
 │    └── training_detail_screen.dart
 └── batches/
      └── batches_screen.dart
```

*File ini dapat digunakan sebagai referensi untuk implementasi View dan integrasi dengan Service Retrofit secara bertahap.*
