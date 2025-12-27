class PathMapper {
  static String mapToFtpUrl({
    required String remotePath,
    required String remotePrefix,
    required String ftpPrefix,
    required String host,
    required int port,
    required String user,
    required String pass,
    String protocol = 'ftp',
  }) {
    // 1. Remote prefix removal
    String relativePath = remotePath;
    if (remotePrefix.isNotEmpty && remotePath.startsWith(remotePrefix)) {
      relativePath = remotePath.substring(remotePrefix.length);
    }
    
    // Ensure relativePath doesn't start with slash if we append it
    if (relativePath.startsWith('/')) {
      relativePath = relativePath.substring(1);
    }

    // 2. Add FTP prefix
    String finalPath = ftpPrefix;
    if (finalPath.isNotEmpty && !finalPath.endsWith('/')) {
      finalPath += '/';
    }
    finalPath += relativePath;

    // 3. Build URL
    final encodedUser = Uri.encodeComponent(user);
    final encodedPass = Uri.encodeComponent(pass);
    
    // Check if protocol needs explicit auth or handled differently
    // sftp://user:pass@host:port/path
    // http://host:port/path (auth maybe in headers or url)
    
    return '$protocol://$encodedUser:$encodedPass@$host:$port/$finalPath';
  }
}
