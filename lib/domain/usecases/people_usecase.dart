import 'package:moovup_test/domain/entities/user.dart';
import 'package:moovup_test/domain/repositories/people_repository.dart';

class PeopleUseCase {
  final PeopleRepository _peopleRepository;

  PeopleUseCase(this._peopleRepository);

  Future<List<User>> getPeople() async {
    return _peopleRepository.getPeople();
  }
}
