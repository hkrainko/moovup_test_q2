import 'package:moovup_test/domain/entities/person.dart';

abstract class PeopleRepository {
  Stream<List<Person>> get peopleBoardcast;
  void refresh();
}
