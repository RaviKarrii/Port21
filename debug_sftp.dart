import 'dart:io';
import 'package:dartssh2/dartssh2.dart';

void main() async {
  final host = '46.232.210.200';
  final port = 22;
  final user = 'naaserver';
  final pass = 'ShankerforU#3';
  final relativePath = 'media/Movies/Maranamass (2025)/Maranamass (2025) WEBRip-1080p.mp4';

  print('CONNECTING to $host...');
  final socket = await SSHSocket.connect(host, port);
  final client = SSHClient(
    socket,
    username: user,
    onPasswordRequest: () => pass,
  );

  print('AUTHENTICATING...');
  await client.authenticated;
  print('AUTHENTICATED!');

  final sftp = await client.sftp();
  print('SFTP INITIALIZED.');

  print('\n--- TEST 1: Relative Path ---');
  try {
    final stat = await sftp.stat(relativePath);
    print('SUCCESS! Found at: $relativePath');
    print('Size: ${stat.size}');
  } catch (e) {
    print('FAILED: $e');
  }

  print('\n--- TEST 2: Absolute Path (Root /) ---');
  try {
    final absPath = '/$relativePath';
    final stat = await sftp.stat(absPath);
    print('SUCCESS! Found at: $absPath');
  } catch (e) {
    print('FAILED: $e');
  }

  print('\n--- TEST 3: Resolving PWD ---');
  final pwdResult = await client.run('pwd');
  final homeDir = String.fromCharCodes(pwdResult).trim();
  print('PWD returned: $homeDir');

  print('\n--- TEST 4: Full Absolute Path (PWD + Relative) ---');
  String fullPath = homeDir;
  if (!fullPath.endsWith('/')) fullPath += '/';
  fullPath += relativePath;
  
  try {
    final stat = await sftp.stat(fullPath);
    print('SUCCESS! Found at: $fullPath');
  } catch (e) {
    print('FAILED: $e');
  }

  print('\n--- TEST 5: URL Construction ---');
  final uri = Uri(
    scheme: 'sftp',
    userInfo: '$user:$pass',
    host: host,
    port: port,
    path: fullPath,
  );
  print('Proposed URL: $uri');
  print('Proposed URL (String): ${uri.toString()}');

  client.close();
  print('\nDONE.');
}
