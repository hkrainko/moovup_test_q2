import 'package:moovup_test/domain/entities/person.dart';

abstract class PeopleRemoteDataSource {
  Future<List<Person>> getPeople();
}
