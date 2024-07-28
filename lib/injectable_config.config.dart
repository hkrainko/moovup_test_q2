// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:hive/hive.dart' as _i979;
import 'package:http/http.dart' as _i519;
import 'package:injectable/injectable.dart' as _i526;

import 'data/data_sources/people_dummy_remote_data_source_impl.dart' as _i263;
import 'data/data_sources/people_hive_local_data_source_impl.dart' as _i515;
import 'data/data_sources/people_http_remote_data_source_impl.dart' as _i573;
import 'data/data_sources/people_local_data_source.dart' as _i509;
import 'data/data_sources/people_remote_data_source.dart' as _i592;
import 'data/repositories/people_repository_impl.dart' as _i344;
import 'domain/repositories/people_repository.dart' as _i220;
import 'domain/usecases/people_usecase.dart' as _i216;
import 'injectable_config.dart' as _i404;

const String _prod = 'prod';
const String _dev = 'dev';

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i519.Client>(() => registerModule.client);
    await gh.lazySingletonAsync<_i979.HiveInterface>(
      () => registerModule.hive,
      preResolve: true,
    );
    gh.factory<_i509.PeopleLocalDataSource>(
      () => _i515.PeopleHiveLocalDataSourceImpl(gh<_i979.HiveInterface>()),
      registerFor: {_prod},
    );
    gh.factory<String>(
      () => registerModule.bearerToken,
      instanceName: 'BearerToken',
    );
    gh.factory<_i592.PeopleRemoteDataSource>(
      () => _i263.PeopleDummyRemoteDataSourceImpl(),
      registerFor: {_dev},
    );
    gh.factory<_i592.PeopleRemoteDataSource>(
      () => _i573.PeopleHttpRemoteDataSourceImpl(
        gh<_i519.Client>(),
        gh<String>(instanceName: 'BearerToken'),
      ),
      registerFor: {_prod},
    );
    gh.factory<_i220.PeopleRepository>(() => _i344.PeopleRepositoryImpl(
          gh<_i592.PeopleRemoteDataSource>(),
          gh<_i509.PeopleLocalDataSource>(),
        ));
    gh.factory<_i216.PeopleUseCase>(
        () => _i216.PeopleUseCase(gh<_i220.PeopleRepository>()));
    return this;
  }
}

class _$RegisterModule extends _i404.RegisterModule {}
