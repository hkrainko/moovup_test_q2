import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';
import 'package:moovup_test/data/data_sources/people_local_data_source.dart';
import 'package:moovup_test/domain/entities/person.dart';

@Environment(Environment.prod)
@Injectable(as: PeopleLocalDataSource)
class PeopleHiveLocalDataSourceImpl implements PeopleLocalDataSource {
  final HiveInterface _hive;

  PeopleHiveLocalDataSourceImpl(this._hive);

  @override
  Future<List<Person>> getPeople() async {
    final box = await _hive.openBox('people');
    return box.values.cast<Person>().toList();
  }

  @override
  Future<Person> getPerson(String id) async {
    final box = await _hive.openBox('people');
    return box.values.cast<Person>().firstWhere((element) => element.id == id);
  }

  @override
  Future<void> savePeople(List<Person> people) async {
    final box = await _hive.openBox('people');
    await box.clear();
    await box.addAll(people);
  }
}
