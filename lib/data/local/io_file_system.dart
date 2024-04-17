import 'package:file/file.dart';
import 'package:file/local.dart';
import 'package:flutter_cache_manager/src/storage/file_system/file_system.dart' as cm;
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class IOFileSystem implements cm.FileSystem {
  final Future<Directory> _fileDir;

  IOFileSystem(String key) : _fileDir = createDirectory(key);

  static Future<Directory> createDirectory(String key) async {
    // use documents directory instead of temp
    var baseDir = await getApplicationDocumentsDirectory();
    var path = p.join(baseDir.path, key);

    var fs = const LocalFileSystem();
    var directory = fs.directory((path));
    await directory.create(recursive: true);
    return directory;
  }

  @override
  Future<File> createFile(String name) async {
    return (await _fileDir).childFile(name);
  }
}