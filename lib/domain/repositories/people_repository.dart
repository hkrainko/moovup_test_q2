import 'package:moovup_test/domain/entities/user.dart';

abstract class PeopleRepository {
  Future<List<User>> getPeople();
}
