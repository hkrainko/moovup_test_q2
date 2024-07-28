import 'package:moovup_test/domain/entities/person.dart';

abstract class PeopleLocalDataSource {
  Future<List<Person>> getPeople();

  Future<Person> getPerson(String id);

  Future<void> savePeople(List<Person> people);
}
