import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/usecases/people_usecase.dart';
import 'package:moovup_test/injectable_config.dart';
import 'package:moovup_test/presentation/map/map_screen.dart';

import '../home/home_screen_test.mocks.dart';

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

  group('MapView', () {
    testWidgets('shows loading indicator when waiting for data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MapScreen(),
        ),
      );

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('shows error message when an error occurs',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MapScreen(),
        ),
      );

      streamController.addError('Some error');

      await tester.pumpAndSettle();

      expect(find.text('Error: Some error'), findsOneWidget);
    });

    testWidgets('shows no data message when there is no data',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MapScreen(),
        ),
      );

      streamController.add([]);
      await tester
          .pumpAndSettle(); // Rebuilds the widget with the new stream state

      expect(find.text('No data available'), findsOneWidget);
    });

    testWidgets('shows MapView when data is available',
        (WidgetTester tester) async {
      final people = [
        Person(
          id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
          name: Name(last: 'Bass', first: 'Bradley'),
          email: 'aida.griffith@sybixtex.show',
          picture: 'https://placebear.com/225/210',
          location: Location(latitude: 22.38, longitude: 22.38),
        )
      ];

      await tester.pumpWidget(
        const MaterialApp(
          home: MapScreen(),
        ),
      );

      streamController.add(people);

      await tester.pumpAndSettle();
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(find.byType(GoogleMap), findsOneWidget);
    });
  });
}
