import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_test/data/data_sources/people_local_data_source.dart';
import 'package:moovup_test/data/data_sources/people_remote_data_source.dart';
import 'package:moovup_test/data/repositories/people_repository_impl.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/injectable_config.dart';

import 'poeple_repository_impl_test.mocks.dart';

@GenerateNiceMocks(
    [MockSpec<PeopleRemoteDataSource>(), MockSpec<PeopleLocalDataSource>()])
void main() {
  late PeopleRemoteDataSource peopleRemoteDataSource;
  late PeopleLocalDataSource peopleLocalDataSource;
  late PeopleRepositoryImpl peopleRepositoryImpl;

  setUp(() {
    peopleRemoteDataSource = MockPeopleRemoteDataSource();
    peopleLocalDataSource = MockPeopleLocalDataSource();
    peopleRepositoryImpl = PeopleRepositoryImpl(
      peopleRemoteDataSource,
      peopleLocalDataSource,
    );
  });

  tearDown(() {
    getIt.reset();
  });

  final people1 = [
    Person(
      id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
      name: Name(last: 'Bass', first: 'Bradley'),
      email: 'aida.griffith@sybixtex.show',
      picture: 'https://placebear.com/225/210',
      location: Location(latitude: 22.38, longitude: null),
    ),
    Person(
      id: 'ae61bba4-4110-45a7-84c5-ab1c08a86a1d',
      name: Name(last: 'Calhoun', first: 'Amparo'),
      email: 'sue.patterson@exoteric.press',
      picture: 'https://placebear.com/60/121',
      location: Location(latitude: 22.37, longitude: 113.34),
    ),
  ];

  final people2 = [
    Person(
      id: '86615bf5-9815-4f70-8ade-a76d2a6c3d56',
      name: Name(last: 'Allen', first: 'Celina'),
      email: 'lula.dillard@syntac.pn',
      picture: 'https://placebear.com/85/236',
      location: Location(latitude: 22.35, longitude: null),
    ),
  ];

  group('PeopleRepositoryImpl', () {
    test('Should get people from remote and save to local initially', () async {
      when(peopleLocalDataSource.getPeople()).thenAnswer((_) async => []);
      when(peopleRemoteDataSource.getPeople()).thenAnswer((_) async => people1);

      peopleRepositoryImpl.refresh();

      expectLater(
          peopleRepositoryImpl.peopleBoardcast, emitsInOrder([[], people1]));
      await untilCalled(peopleLocalDataSource.getPeople());
      await untilCalled(peopleRemoteDataSource.getPeople());

      verify(peopleLocalDataSource.getPeople());
      verify(peopleRemoteDataSource.getPeople());

      // replace the local data with remote one
      verify(peopleLocalDataSource.savePeople(people1));
    });

    test(
        'If remote data is the same, only return local and should not save to local',
        () async {
      when(peopleLocalDataSource.getPeople()).thenAnswer((_) async => people1);
      when(peopleRemoteDataSource.getPeople()).thenAnswer((_) async => people1);

      peopleRepositoryImpl.refresh();

      expectLater(
          peopleRepositoryImpl.peopleBoardcast, emitsInOrder([people1]));
      await untilCalled(peopleLocalDataSource.getPeople());
      await untilCalled(peopleRemoteDataSource.getPeople());

      verify(peopleLocalDataSource.getPeople());
      verify(peopleRemoteDataSource.getPeople());
      // should not save to local
      verifyNever(peopleLocalDataSource.savePeople(people1));
    });

    test(
        'If remote data is different, should replace the local data with remote one',
        () async {
      when(peopleLocalDataSource.getPeople()).thenAnswer((_) async => people1);
      when(peopleRemoteDataSource.getPeople()).thenAnswer((_) async => people2);

      peopleRepositoryImpl.refresh();

      expectLater(peopleRepositoryImpl.peopleBoardcast,
          emitsInOrder([people1, people2]));
      await untilCalled(peopleLocalDataSource.getPeople());
      await untilCalled(peopleRemoteDataSource.getPeople());

      verify(peopleLocalDataSource.getPeople());
      verify(peopleRemoteDataSource.getPeople());

      // replace the local data with remote one
      verify(peopleLocalDataSource.savePeople(people2));
    });
  });
}
