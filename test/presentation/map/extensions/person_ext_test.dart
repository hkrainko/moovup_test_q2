import 'package:flutter_test/flutter_test.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/extensions/person_ext.dart';

void main() {
  group('PersonExtension', () {
    test('toMarker returns correct Marker when location is valid', () {
      final person = Person(
        id: '1',
        name: Name(last: 'Doe', first: 'John'),
        email: 'john.doe@example.com',
        picture: 'https://example.com/john.jpg',
        location: Location(latitude: 12.34, longitude: 56.78),
      );

      final marker = person.toMarker(true, () {});

      expect(marker, isNotNull);
      expect(marker?.markerId.value, '1');
      expect(marker?.position.latitude, 12.34);
      expect(marker?.position.longitude, 56.78);
      expect(marker?.infoWindow.title, 'John Doe→');
    });

    test(
        'toMarker returns correct Marker without arrow when showArrow is false',
        () {
      final person = Person(
        id: '2',
        name: Name(last: 'Smith', first: 'Jane'),
        email: 'jane.smith@example.com',
        picture: 'https://example.com/jane.jpg',
        location: Location(latitude: 23.45, longitude: 67.89),
      );

      final marker = person.toMarker(false, null);

      expect(marker, isNotNull);
      expect(marker?.markerId.value, '2');
      expect(marker?.position.latitude, 23.45);
      expect(marker?.position.longitude, 67.89);
      expect(marker?.infoWindow.title, 'Jane Smith');
    });

    test('toMarker returns null when location latitude is null', () {
      final person = Person(
        id: '3',
        name: Name(last: 'Brown', first: 'Charlie'),
        email: 'charlie.brown@example.com',
        picture: 'https://example.com/charlie.jpg',
        location: Location(latitude: null, longitude: 45.67),
      );

      final marker = person.toMarker(true, null);

      expect(marker, isNull);
    });

    test('toMarker returns null when location longitude is null', () {
      final person = Person(
        id: '4',
        name: Name(last: 'White', first: 'Betty'),
        email: 'betty.white@example.com',
        picture: 'https://example.com/betty.jpg',
        location: Location(latitude: 12.34, longitude: null),
      );

      final marker = person.toMarker(true, null);

      expect(marker, isNull);
    });

    test('toMarker returns correct Marker with onTap callback', () {
      final person = Person(
        id: '5',
        name: Name(last: 'Green', first: 'Eve'),
        email: 'eve.green@example.com',
        picture: 'https://example.com/eve.jpg',
        location: Location(latitude: 34.56, longitude: 78.90),
      );

      bool tapped = false;
      void onTap() {
        tapped = true;
      }

      final marker = person.toMarker(true, onTap);

      expect(marker, isNotNull);
      expect(marker?.infoWindow.onTap, isNotNull);

      // Simulate the tap
      marker?.infoWindow.onTap?.call();
      expect(tapped, isTrue);
    });
  });
}
