import 'package:moovup_test/data/data_sources/people_data_source.dart';
import 'package:moovup_test/domain/entities/user.dart';
import 'package:moovup_test/domain/repositories/people_repository.dart';

class PeopleRepositoryImpl implements PeopleRepository {
  final PeopleDataSource peopleDataSource;

  PeopleRepositoryImpl(this.peopleDataSource);

  @override
  Future<List<User>> getPeople() async {
    return peopleDataSource.getPeople();
  }
}
