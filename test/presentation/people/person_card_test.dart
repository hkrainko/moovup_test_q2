import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/people/person_card.dart';

void main() {
  setUp(() {});

  tearDown(() {});

  group('PersonCard', () {
    testWidgets('Person Card without email', (WidgetTester tester) async {
      final person = Person(
        id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
        name: Name(last: 'Bass', first: 'Bradley'),
        email: 'aida.griffith@sybixtex.show',
        picture: 'https://placebear.com/225/210',
        location: Location(latitude: 22.38, longitude: null),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PersonCard(person: person, showEmail: false),
        ),
      );

      expect(find.byType(PersonCard), findsOneWidget);
      expect(find.text('aida.griffith@sybixtex.show', skipOffstage: false),
          findsNothing);
      expect(find.text('Bradley Bass'), findsOneWidget);
    });

    testWidgets('Person Card with email', (WidgetTester tester) async {
      final person = Person(
        id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
        name: Name(last: 'Bass', first: 'Bradley'),
        email: 'aida.griffith@sybixtex.show',
        picture: 'https://placebear.com/225/210',
        location: Location(latitude: 22.38, longitude: null),
      );

      await tester.pumpWidget(
        MaterialApp(
          home: PersonCard(person: person, showEmail: true),
        ),
      );

      expect(find.byType(PersonCard), findsOneWidget);
      expect(find.text('aida.griffith@sybixtex.show', skipOffstage: false),
          findsOneWidget);
      expect(find.text('Bradley Bass'), findsOneWidget);
    });
  });
}
