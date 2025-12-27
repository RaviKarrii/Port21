# Port21

Port21 is a high-performance, private media client built with Flutter. It aggregates your media from **Radarr** and **Sonarr**, enabling seamless streaming via **SFTP** and robust offline playback.

## ✨ Features

*   **Unified Library**: Browse Movies (Radarr) and Series (Sonarr) in a sleek, Netflix-style interface.
*   **Smart Playback**:
    *   **Prioritize Local**: Automatically plays downloaded files if available (zero buffering).
    *   **Direct Streaming**: Streams directly from your server via SFTP without transcoding.
*   **Advanced Player**:
    *   **Internal Player**: Powered by `media_kit` (MPV) for broad format support (MKV, MP4, HEVC, HDR).
    *   **External Player Support**: Open streams in VLC, MX Player, or nPlayer.
    *   **Casting**: Cast local files to supported receivers (Experimental).
*   **Offline Mode**:
    *   Download movies and episodes for offline viewing.
    *   Background download management via `flutter_downloader`.
    *   Smart storage management (View used space, clear cache).
*   **Secure**: All connections are handled securely via SSH/SFTP.

## 🏗️ Architecture

The project follows a **Feature-First, Riverpod-based** Clean Architecture.

### Core Technologies
*   **Framework**: Flutter (Dart)
*   **State Management**: `flutter_riverpod` (v2, code-gen)
*   **Persistence**: `isar` (NoSQL, high performance)
*   **Networking**: `dio` (API), `dartssh2` (SFTP/SSH), `flutter_downloader` (Background Downloads)
*   **Playback**: `media_kit` (Video rendering)

### Folder Structure
```
lib/
├── core/               # Shared utilities, constants, exceptions
├── features/           # Feature-based modules
│   ├── library/        # Movie/Series Domain, Repositories, UI
│   ├── player/         # Video Player, SftpStreamServer, Casting
│   ├── download/       # DownloadService, DB Entities, Queue UI
│   ├── settings/       # Configuration, Server details
│   └── home/           # Navigation shell
└── main.dart           # App Entry point
```

### Key Components
*   **SftpStreamServer**: A local HTTP proxy that tunnels SFTP requests to a localhost URL, allowing standard video players (that don't speak SFTP) to seek and buffer remote files efficiently.
*   **DownloadService**: Manages the lifecycle of downloads, syncing state between the file system, Isar database, and the background downloader isolate.
*   **LibraryRepository**: Syncs metadata from Radarr/Sonarr to the local Isar database for instant "offline-first" browsing.

## 🛠️ Setup & Build

### Prerequisites
*   Flutter SDK (>=3.10.x)
*   Java 17 (for Android Build)
*   Android SDK / Studio

### Installation

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/your-username/port21.git
    cd port21
    ```

2.  **Install Dependencies**:
    ```bash
    flutter pub get
    ```

3.  **Run Code Generation** (Required for Riverpod/Isar/Freezed):
    ```bash
    flutter pub run build_runner build --delete-conflicting-outputs
    ```

### Running Locally
```bash
flutter run
```

### Building for Release (Android)

To build a simplified universal APK (recommended for testing):
```bash
flutter build apk --release
```

To build split APKs (smaller size due to native lib separation):
```bash
flutter build apk --split-per-abi --release
```

The output APKs will be located in: `build/app/outputs/flutter-apk/`

### Configuration
On the first launch, go to **Settings** and configure:
1.  **Server Address**: IP/Hostname of your server.
2.  **SSH/SFTP Defaults**: User, Password, Port (22).
3.  **Radarr/Sonarr**: API Keys and Ports (e.g., 7878, 8989).
4.  **Local/Remote Paths**: Map your server's file paths (e.g., `/mnt/media`) to the SFTP root if they differ.

## 🤝 Contributing
1.  Fork the repo.
2.  Create a feature branch (`git checkout -b feature/amazing-feature`).
3.  Commit changes.
4.  Push to branch.
5.  Open a Pull Request.

## 📄 License
MIT License.
