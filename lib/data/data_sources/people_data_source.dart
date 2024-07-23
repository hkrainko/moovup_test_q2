import 'package:moovup_test/domain/entities/user.dart';

abstract class PeopleDataSource {
  Future<List<User>> getPeople();
}
