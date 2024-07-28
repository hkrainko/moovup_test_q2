import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_test/data/data_sources/people_hive_local_data_source_impl.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/injectable_config.dart';

import 'people_hive_local_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<Box>(), MockSpec<HiveInterface>()])
void main() {
  late MockHiveInterface mockHive;
  late MockBox mockBox;
  late PeopleHiveLocalDataSourceImpl dataSource;

  setUp(() {
    mockHive = MockHiveInterface();
    mockBox = MockBox();
    dataSource = PeopleHiveLocalDataSourceImpl(mockHive);

    // Mock the interaction with the Hive openBox method
    when(mockHive.openBox(any)).thenAnswer((_) async => mockBox);
  });

  tearDown(() {
    getIt.reset();
  });

  group('getPeople', () {
    test('should return a list of User when there are users in the box',
        () async {
      // Arrange
      final people = [
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
      when(mockBox.values).thenReturn(people);

      // Act
      final result = await dataSource.getPeople();

      // Assert
      expect(result, people);
      verify(mockHive.openBox('people')).called(1);
      verify(mockBox.values).called(1);
    });
  });

  group('getPerson', () {
    test('should return a User when the user is found in the box', () async {
      // Arrange
      final people = Person(
        id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
        name: Name(last: 'Bass', first: 'Bradley'),
        email: 'aida.griffith@sybixtex.show',
        picture: 'https://placebear.com/225/210',
        location: Location(latitude: 22.38, longitude: null),
      );
      when(mockBox.values).thenReturn([people]);

      // Act
      final result =
          await dataSource.getPerson('ae736d8f-5a08-4bab-8e30-1eb2079e5dc2');

      // Assert
      expect(result, people);
      verify(mockHive.openBox('people')).called(1);
      verify(mockBox.values).called(1);
    });

    test('should throw StateError when the user is not found in the box',
        () async {
      // Arrange
      when(mockBox.values).thenReturn([]);

      // Act
      final call = dataSource.getPerson;

      // Assert
      expect(() => call('1'), throwsStateError);
      verify(mockHive.openBox('people')).called(1);
      // verify(mockBox.values).called(1);
    });
  });

  group('savePeople', () {
    test('should clear the box and add all users', () async {
      // Arrange
      final people = [
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

      // Act
      await dataSource.savePeople(people);

      // Assert
      verify(mockHive.openBox('people')).called(1);
      verify(mockBox.clear()).called(1);
      verify(mockBox.addAll(people)).called(1);
    });
  });
}
