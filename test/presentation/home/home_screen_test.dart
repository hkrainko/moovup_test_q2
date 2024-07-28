import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/repositories/people_repository.dart';
import 'package:moovup_test/domain/usecases/people_usecase.dart';
import 'package:moovup_test/injectable_config.dart';
import 'package:moovup_test/presentation/home/home_screen.dart';

import 'home_screen_test.mocks.dart';

@GenerateNiceMocks([MockSpec<PeopleUseCase>()])
void main() {
  late MockPeopleUseCase mockPeopleUseCase;
  late StreamController<List<Person>> streamController;

  setUp(() {
    mockPeopleUseCase = MockPeopleUseCase();
    getIt.registerSingleton<PeopleUseCase>(mockPeopleUseCase);
    streamController = StreamController<List<Person>>.broadcast();
    when(mockPeopleUseCase.peopleBoardcast)
        .thenAnswer((_) => streamController.stream);
  });

  tearDown(() {
    streamController.close();
    getIt.reset();
  });

  group('HomeScreen', () {
    testWidgets('People List', (WidgetTester tester) async {
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

      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      streamController.add(people);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('Bradley Bass'), findsOne);
    });

    testWidgets('People List Empty', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: HomeScreen(),
        ),
      );

      streamController.add([]);
      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.text('No data available'), findsOne);
    });
  });
}

class MockPeopleRepository extends PeopleRepository {
  final List<Person> people;

  MockPeopleRepository({required this.people});

  @override
  Stream<List<Person>> get peopleBoardcast => Stream.value(people);

  @override
  void refresh() {}
}
