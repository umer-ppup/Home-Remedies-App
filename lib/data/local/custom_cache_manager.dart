import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:home_remedies/shared/constants/string_resources.dart';
import 'io_file_system.dart';

class CustomCacheManager {
  static CacheManager? instance;

  static CacheManager? getInstance(){
    if(instance != null){
      return instance;
    }
    instance = CacheManager(
      Config(
        StringResources.cacheKey,
        stalePeriod: const Duration(days: 7),
        repo: JsonCacheInfoRepository(databaseName: StringResources.cacheKey),
        fileSystem: IOFileSystem(StringResources.cacheKey),
        fileService: HttpFileService(),
      ),
    );

    return instance;
  }
}