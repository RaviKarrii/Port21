import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../library/data/remote/radarr_service.dart';
import '../../library/data/remote/sonarr_service.dart';
import '../data/settings_repository.dart';
import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:port21/features/settings/domain/settings.dart';
import 'package:path_provider/path_provider.dart';
import 'package:url_launcher/url_launcher.dart'; // Ensure usage for opening folder

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  late TextEditingController _radarrUrlCtrl;
  late TextEditingController _radarrKeyCtrl;
  late TextEditingController _sonarrUrlCtrl;
  late TextEditingController _sonarrKeyCtrl;
  late TextEditingController _tmdbKeyCtrl;
  
  late TextEditingController _ftpHostCtrl;
  late TextEditingController _ftpPortCtrl;
  late TextEditingController _ftpUserCtrl;
  late TextEditingController _ftpPassCtrl;
  late TextEditingController _remotePrefixCtrl;
  late TextEditingController _ftpPrefixCtrl;
  String _streamProtocol = 'ftp';
  String _downloadPath = "Loading...";

  @override
  void initState() {
    super.initState();
    final currentSettings = ref.read(settingsRepositoryProvider).getSettings();
    
    _radarrUrlCtrl = TextEditingController(text: currentSettings.radarrUrl);
    _radarrKeyCtrl = TextEditingController(text: currentSettings.radarrApiKey);
    _sonarrUrlCtrl = TextEditingController(text: currentSettings.sonarrUrl);
    _sonarrKeyCtrl = TextEditingController(text: currentSettings.sonarrApiKey);
    _tmdbKeyCtrl = TextEditingController(text: currentSettings.tmdbApiKey);
    
    _ftpHostCtrl = TextEditingController(text: currentSettings.ftpHost);
    _ftpPortCtrl = TextEditingController(text: currentSettings.ftpPort.toString());
    _ftpUserCtrl = TextEditingController(text: currentSettings.ftpUser);
    _ftpPassCtrl = TextEditingController(text: currentSettings.ftpPassword);
    
    _remotePrefixCtrl = TextEditingController(text: currentSettings.remotePathPrefix);
    _ftpPrefixCtrl = TextEditingController(text: currentSettings.ftpPathPrefix);
    _streamProtocol = currentSettings.streamProtocol.isEmpty ? 'ftp' : currentSettings.streamProtocol;
    
    _loadDownloadPath();
  }

  Future<void> _loadDownloadPath() async {
     try {
        final dir = await getApplicationDocumentsDirectory();
        final downloadDir = Directory('${dir.path}/Downloads'); // Match DownloadService logic
        if (!await downloadDir.exists()) {
           await downloadDir.create(recursive: true);
        }
        if (mounted) setState(() => _downloadPath = downloadDir.path);
     } catch (e) {
        if (mounted) setState(() => _downloadPath = "Error loading path");
     }
  }

  @override
  void dispose() {
    _radarrUrlCtrl.dispose();
    _radarrKeyCtrl.dispose();
    _sonarrUrlCtrl.dispose();
    _sonarrKeyCtrl.dispose();
    _tmdbKeyCtrl.dispose();
    _ftpHostCtrl.dispose();
    _ftpPortCtrl.dispose();
    _ftpUserCtrl.dispose();
    _ftpPassCtrl.dispose();
    _remotePrefixCtrl.dispose();
    _ftpPrefixCtrl.dispose();
    super.dispose();
  }

  Future<void> _exportSettings() async {
     final settings = ref.read(settingsRepositoryProvider).getSettings();
     final jsonStr = jsonEncode(settings.toJson());
     
     try {
        // Platform specific save
        if (Platform.isMacOS || Platform.isWindows || Platform.isLinux) {
           String? outputFile = await FilePicker.platform.saveFile(
             dialogTitle: 'Save Settings Backup',
             fileName: 'port21_backup.json',
             allowedExtensions: ['json'],
             type: FileType.custom,
           );
   
           if (outputFile != null) {
              final file = File(outputFile);
              await file.writeAsString(jsonStr);
              if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Backup saved successfully")));
           }
        } else {
           // Mobile fallback? Copy to clipboard for now
           // Clipboard.setData(ClipboardData(text: jsonStr));
           // ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("Settings JSON copied to clipboard")));
           
           // Or save to documents and show path
           final dir = await getApplicationDocumentsDirectory();
           final file = File('${dir.path}/port21_backup.json');
           await file.writeAsString(jsonStr);
           if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saved to ${file.path}")));
        }
     } catch (e) {
        if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Export failed: $e")));
     }
  }

  Future<void> _restoreSettings() async {
     try {
       FilePickerResult? result = await FilePicker.platform.pickFiles(
         type: FileType.custom,
         allowedExtensions: ['json', 'txt'],
       );

       if (result != null && result.files.single.path != null) {
          final file = File(result.files.single.path!);
          final content = await file.readAsString();
          _applyConfigFromJson(content);
       }
     } catch (e) {
       if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error picking file: $e')));
     }
  }

  Future<void> _testConnections() async {
     if (!_formKey.currentState!.validate()) {
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Please fill all required fields first.')));
       return;
     }
     
     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Testing connections...')));
     
     final dio = Dio();
     dio.options.connectTimeout = const Duration(seconds: 5);
     
     bool radarrOk = false;
     try {
       final radarrService = RadarrService(dio, baseUrl: _radarrUrlCtrl.text.trim(), apiKey: _radarrKeyCtrl.text.trim());
       radarrOk = await radarrService.testConnection();
     } catch (_) {}

     bool sonarrOk = false;
     try {
       final sonarrService = SonarrService(dio, baseUrl: _sonarrUrlCtrl.text.trim(), apiKey: _sonarrKeyCtrl.text.trim());
       sonarrOk = await sonarrService.testConnection();
     } catch (_) {}
     
     if (mounted) {
       showDialog(
         context: context,
         builder: (context) => AlertDialog(
           title: const Text("Connection Results"),
           content: Column(
             mainAxisSize: MainAxisSize.min,
             children: [
               ListTile(
                 leading: Icon(radarrOk ? Icons.check_circle : Icons.error, color: radarrOk ? Colors.green : Colors.red),
                 title: const Text("Radarr"),
                 subtitle: Text(radarrOk ? "Connected" : "Failed"),
               ),
               ListTile(
                 leading: Icon(sonarrOk ? Icons.check_circle : Icons.error, color: sonarrOk ? Colors.green : Colors.red),
                 title: const Text("Sonarr"),
                 subtitle: Text(sonarrOk ? "Connected" : "Failed"),
               ),
             ],
           ),
           actions: [
             TextButton(onPressed: () => Navigator.pop(context), child: const Text("OK"))
           ],
         ),
       );
     }
  }
  
  void _applyConfigFromJson(String jsonStr) {
    try {
      final Map<String, dynamic> json = jsonDecode(jsonStr);
      
      setState(() {
        if (json['radarrUrl'] != null) _radarrUrlCtrl.text = json['radarrUrl'];
        if (json['radarrApiKey'] != null) _radarrKeyCtrl.text = json['radarrApiKey'];
        if (json['sonarrUrl'] != null) _sonarrUrlCtrl.text = json['sonarrUrl'];
        if (json['sonarrApiKey'] != null) _sonarrKeyCtrl.text = json['sonarrApiKey'];
        if (json['ftpHost'] != null) _ftpHostCtrl.text = json['ftpHost'];
        if (json['ftpPort'] != null) _ftpPortCtrl.text = json['ftpPort'].toString();
        if (json['ftpUser'] != null) _ftpUserCtrl.text = json['ftpUser'];
        if (json['ftpPassword'] != null) _ftpPassCtrl.text = json['ftpPassword'];
        if (json['remotePathPrefix'] != null) _remotePrefixCtrl.text = json['remotePathPrefix'];
        if (json['ftpPathPrefix'] != null) _ftpPrefixCtrl.text = json['ftpPathPrefix'];
        if (json['streamProtocol'] != null) {
           _streamProtocol = json['streamProtocol'];
        } else if (json['ftpIsSecure'] == true) {
           _streamProtocol = 'ftps';
        }
      });

      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Configuration Applied! Click Save to persist.')));
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Invalid JSON Configuration Format')));
    }
  }

  void _saveSettings() async {
    if (_formKey.currentState!.validate()) {
      final repo = ref.read(settingsRepositoryProvider);
      
      final newSettings = Settings(
        radarrUrl: _radarrUrlCtrl.text.trim(),
        radarrApiKey: _radarrKeyCtrl.text.trim(),
        sonarrUrl: _sonarrUrlCtrl.text.trim(),
        sonarrApiKey: _sonarrKeyCtrl.text.trim(),
        ftpHost: _ftpHostCtrl.text.trim(),
        ftpPort: int.tryParse(_ftpPortCtrl.text.trim()) ?? 21,
        ftpUser: _ftpUserCtrl.text.trim(),
        ftpPassword: _ftpPassCtrl.text.trim(),
        remotePathPrefix: _remotePrefixCtrl.text.trim(),
        ftpPathPrefix: _ftpPrefixCtrl.text.trim(),
        streamProtocol: _streamProtocol,
        tmdbApiKey: _tmdbKeyCtrl.text.trim(),
      );

      await repo.saveSettings(newSettings);
      
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Settings Saved')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Settings"),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveSettings,
          )
        ],
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
             // Backup / Restore Row
             Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: Row(
                  children: [
                    Expanded(
                      child: FilledButton.icon(
                         onPressed: _exportSettings,
                         icon: const Icon(Icons.download),
                         label: const Text("BACKUP JSON"),
                         style: FilledButton.styleFrom(
                            backgroundColor: Colors.teal,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                         ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: FilledButton.icon(
                         onPressed: _restoreSettings,
                         icon: const Icon(Icons.upload_file),
                         label: const Text("RESTORE JSON"),
                         style: FilledButton.styleFrom(
                            backgroundColor: Colors.orangeAccent,
                            padding: const EdgeInsets.symmetric(vertical: 16),
                         ),
                      ),
                    ),
                  ],
                ),
             ),
             
             // Download Location Section
             _buildSectionHeader("Storage & Downloads"),
             Container(
               padding: const EdgeInsets.all(12),
               decoration: BoxDecoration(
                 color: const Color(0xFF1E1E1E),
                 borderRadius: BorderRadius.circular(8),
                 border: Border.all(color: Colors.white10),
               ),
               child: Column(
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                    const Text("Download Location:", style: TextStyle(color: Colors.grey, fontSize: 12)),
                    const SizedBox(height: 4),
                    SelectableText(_downloadPath, style: const TextStyle(color: Colors.white, fontFamily: 'Courier')),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                         TextButton.icon(
                           onPressed: () {
                              _loadDownloadPath().then((_) {
                                 ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Refreshed: $_downloadPath")));
                              });
                           },
                           icon: const Icon(Icons.refresh, size: 16),
                           label: const Text("REFRESH"),
                         ),
                         const Spacer(),
                         OutlinedButton.icon(
                           onPressed: () async {
                              final uri = Uri.parse('file://$_downloadPath');
                              if (await canLaunchUrl(uri)) {
                                 launchUrl(uri);
                              } else {
                                 // Fallback try open
                                 launchUrl(Uri.parse('file://${_downloadPath}'));
                              }
                           },
                           icon: const Icon(Icons.folder_open),
                           label: const Text("OPEN FOLDER"),
                         )
                      ],
                    )
                 ],
               ),
             ),
             const SizedBox(height: 24),
             
             // Connections
             Padding(
                padding: const EdgeInsets.only(bottom: 24),
                child: OutlinedButton.icon(
                   onPressed: _testConnections,
                   icon: const Icon(Icons.wifi_find),
                   label: const Text("TEST CONNECTIONS"),
                   style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                   ),
                ),
             ),
             
            _buildSectionHeader("Radarr (Movies)"),
            _buildTextField("Base URL", _radarrUrlCtrl),
            _buildTextField("API Key", _radarrKeyCtrl),
            
            const SizedBox(height: 24),
            _buildSectionHeader("Sonarr (Series)"),
            _buildTextField("Base URL", _sonarrUrlCtrl),
            _buildTextField("API Key", _sonarrKeyCtrl),

            const SizedBox(height: 24),
            _buildSectionHeader("TMDB"),
            _buildTextField("API Key", _tmdbKeyCtrl),
            
            const SizedBox(height: 24),
            _buildSectionHeader("FTP Configuration"),
            Row(
              children: [
                Expanded(flex: 3, child: _buildTextField("Host", _ftpHostCtrl)),
                const SizedBox(width: 8),
                Expanded(flex: 1, child: _buildTextField("Port", _ftpPortCtrl, isNumber: true)),
              ],
            ),
            _buildTextField("Username", _ftpUserCtrl),
            _buildTextField("Password", _ftpPassCtrl, isObscure: true),
            
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: _streamProtocol,
              dropdownColor: const Color(0xFF282C34),
              decoration: const InputDecoration(labelText: "Protocol", filled: true, fillColor: Color(0xFF1E1E1E)), // Better UI
              style: const TextStyle(color: Colors.white),
              items: const [
                DropdownMenuItem(value: 'ftp', child: Text("FTP (Plain)")),
                DropdownMenuItem(value: 'ftps', child: Text("FTPS (Explicit TLS)")),
                DropdownMenuItem(value: 'sftp', child: Text("SFTP (SSH)")),
                DropdownMenuItem(value: 'http', child: Text("HTTP")),
                DropdownMenuItem(value: 'https', child: Text("HTTPS")),
              ], 
              onChanged: (val) => setState(() => _streamProtocol = val ?? 'ftp'),
            ),

            const SizedBox(height: 24),
            _buildSectionHeader("Path Mapping"),
            _buildTextField("Remote Prefix (Server)", _remotePrefixCtrl),
            _buildTextField("FTP Prefix (Client)", _ftpPrefixCtrl),
            
            const SizedBox(height: 48), // Bottom padding
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00E5FF),
        ),
      ),
    );
  }

  Widget _buildTextField(
    String label, 
    TextEditingController controller, {
    String? hint,
    bool isObscure = false,
    bool isNumber = false,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: TextFormField(
        controller: controller,
        obscureText: isObscure,
        keyboardType: isNumber ? TextInputType.number : TextInputType.text,
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          filled: true,
          fillColor: const Color(0xFF1E1E1E),
          border: const OutlineInputBorder(borderSide: BorderSide.none),
          isDense: true,
        ),
        validator: (value) {
          if (!isNumber && (value == null || value.isEmpty)) {
            if (label.contains("URL") || label.contains("Host")) {
               return 'Required';
            }
          }
          return null;
        },
      ),
    );
  }
}
