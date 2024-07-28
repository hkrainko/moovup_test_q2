import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart';
import 'package:injectable/injectable.dart';
import 'package:moovup_test/data/models/hive/location_adapter.dart';
import 'package:moovup_test/data/models/hive/name_adapter.dart';
import 'package:moovup_test/data/models/hive/user_adapter.dart';
import 'package:moovup_test/injectable_config.config.dart';
import 'package:path_provider/path_provider.dart';

final getIt = GetIt.instance;

@module
abstract class RegisterModule {
  @lazySingleton
  Client get client => Client();

  @Named('BearerToken')
  String get bearerToken => 'b2atclr0nk1po45amg305meheqf4xrjt9a1bo410';

  @preResolve
  @lazySingleton
  Future<HiveInterface> get hive async {
    final hive = Hive;
    final dir = await getApplicationDocumentsDirectory();

    hive.registerAdapter(UserAdapter());
    hive.registerAdapter(LocationAdapter());
    hive.registerAdapter(NameAdapter());
    hive.init(dir.path);
    return hive;
  }
}

@InjectableInit(
  initializerName: 'init',
  preferRelativeImports: true,
  asExtension: true,
)
Future<void> configureDependencies(String env) => getIt.init(environment: env);
