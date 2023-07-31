App Folder Structure

lib
├── app
│   ├── core -> berisi file-file yang merujuk pada konfigurasi aplikasi, ekstensi, dan tema
│   │   ├── app_config.dart
│   │   ├── extension.dart
│   │   └── theme.dart
|   |
│   ├── constants -> berisi semua konstanta yang digunakan di seluruh aplikasi
│   │   ├── string_constants.dart -> berisi konstanta string
│   │   ├── color_constants.dart -> berisi konstanta warna
|   |
│   ├── data -> berisi semua kelas yang berhubungan dengan data
│   │   ├── remote -> berisi semua kelas dan metode yang berhubungan dengan pemanggilan API jaringan
│   │   ├── local -> berisi semua kelas dan metode yang berhubungan dengan database lokal atau penyimpanan data lainnya
│   │   ├── entities -> berisi semua model yang digunakan dalam aplikasi
│   │   └── data_sources -> berisi kelas-kelas yang merujuk pada repositori yang mengatur bagaimana data disimpan atau diambil
|   |
│   ├── providers -> berisi state management menggunakan riverpod, setiap fitur memiliki folder tersendiri
│   │   ├── appstate -> berisi appstate_provider.dart (dan file terkait lainnya jika ada)
│   │   ├── todo -> berisi todo_provider.dart (dan file terkait lainnya jika ada)
│   │   └── user -> berisi user_provider.dart (dan file terkait lainnya jika ada)
|   |
│   ├── routes -> berisi definisi dan konfigurasi semua rute/jalur navigasi di aplikasi
│   │   ├── route_constants.dart -> berisi konstanta jalur
│   │   ├── route_settings.dart -> berisi pengaturan jalur
│   │   └── route_generator.dart -> berfungsi sebagai router yang memetakan konstanta jalur ke layar
|   |
│   ├── modules -> setiap modul memiliki fungsi dan layar yang spesifik
│   │   ├── home -> berisi widget dan file lainnya yang terkait dengan fitur home
│   │   ├── todo -> berisi widget dan file lainnya yang terkait dengan fitur todo
│   │   └── users -> berisi widget dan file lainnya yang terkait dengan fitur users
|   |
│   ├── services -> berisi semua kelas dan metode yang berhubungan dengan layanan eksternal seperti Firebase, push notification, dll
│   │   ├── firebase -> firebase_service.dart
|   |
│   ├── utils -> berisi metode-metode utilitas
│   │   ├── fetch.dart
│   │   └── errors.dart
|   |
│   ├── i18n -> berisi file-file untuk internasionalisasi dan lokalitas
│   │   ├── app_localizations.dart -> berisi kode untuk mendukung banyak bahasa
|   |
│   ├── widgets -> berisi widget-widget yang digunakan secara global di seluruh aplikasi
│       ├── form_fields -> berisi widget-widget yang berhubungan dengan form
│       ├── cards -> berisi widget-widget yang berhubungan dengan card
│       ├── buttons -> berisi widget-widget yang berhubungan dengan button
│       └── widget.dart (global widgets)
|
└── main.dart -> entry point dari aplikasi
