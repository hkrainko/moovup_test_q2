import 'package:injectable/injectable.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/repositories/people_repository.dart';

@Injectable()
class PeopleUseCase {
  final PeopleRepository _peopleRepository;
  PeopleUseCase(this._peopleRepository);

  Stream<List<Person>> get peopleBoardcast => _peopleRepository.peopleBoardcast;
  void refresh() => _peopleRepository.refresh();
}
