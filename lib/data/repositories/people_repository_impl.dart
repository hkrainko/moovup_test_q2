import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:moovup_test/data/data_sources/people_local_data_source.dart';
import 'package:moovup_test/data/data_sources/people_remote_data_source.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/repositories/people_repository.dart';

@Injectable(as: PeopleRepository)
class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleRemoteDataSource _peopleRemoteDataSource;
  final PeopleLocalDataSource _peopleLocalDataSource;

  PeopleRepositoryImpl(
      this._peopleRemoteDataSource, this._peopleLocalDataSource);

  final StreamController<List<Person>> _peopleController =
      StreamController<List<Person>>.broadcast();

  @override
  Stream<List<Person>> get peopleBoardcast => _peopleController.stream;

  @override
  void refresh() async {
    // get local cached data
    final localData = await _peopleLocalDataSource.getPeople();
    _peopleController.add(localData);

    // get remote data
    final remoteData = await _peopleRemoteDataSource.getPeople();

    if (!listEquals(remoteData, localData)) {
      _peopleController.add(remoteData);
      // save remote data to cache
      await _peopleLocalDataSource.savePeople(remoteData);
    }
  }
}
