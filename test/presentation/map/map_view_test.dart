import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:mockito/mockito.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/map_view.dart';
import 'package:moovup_test/presentation/map/no_location_view.dart';

class MockGoogleMapController extends Mock implements GoogleMapController {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}

void main() {
  setUp(() {});

  group('MapView', () {
    testWidgets('shows NoLocationView when there are no markers',
        (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: MapView(people: [], allowNav: true),
        ),
      );

      expect(find.byType(NoLocationView), findsOneWidget);
    });

    testWidgets('creates a map when there are markers',
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
        MaterialApp(
          home: MapView(people: people, allowNav: true),
        ),
      );

      // expect(find.byType(NoLocationView), findsOneWidget);
      expect(find.byType(GoogleMap), findsOneWidget);
    });

    testWidgets('do not a map with lation data is not complete',
        (WidgetTester tester) async {
      final people = [
        Person(
          id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
          name: Name(last: 'Bass', first: 'Bradley'),
          email: 'aida.griffith@sybixtex.show',
          picture: 'https://placebear.com/225/210',
          location: Location(latitude: 22.38, longitude: null),
        )
      ];

      await tester.pumpWidget(
        MaterialApp(
          home: MapView(people: people, allowNav: false),
        ),
      );

      expect(find.byType(NoLocationView), findsOneWidget);
    });
  });
}
