import 'package:flutter_test/flutter_test.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/extensions/people_ext.dart'; // Adjust the import to match your file structure

void main() {
  test('toMarkerSet returns correct Set<Marker> when all locations are valid',
      () {
    final people = [
      Person(
        id: '1',
        name: Name(last: 'Doe', first: 'John'),
        email: 'john.doe@example.com',
        picture: 'https://example.com/john.jpg',
        location: Location(latitude: 12.34, longitude: 56.78),
      ),
      Person(
        id: '2',
        name: Name(last: 'Smith', first: 'Jane'),
        email: 'jane.smith@example.com',
        picture: 'https://example.com/jane.jpg',
        location: Location(latitude: 23.45, longitude: 67.89),
      ),
    ];

    final markers = people.toMarkerSet(true, (id) {});

    expect(markers.length, 2);
    expect(markers.any((marker) => marker.markerId.value == '1'), isTrue);
    expect(markers.any((marker) => marker.markerId.value == '2'), isTrue);
  });

  test('toMarkerSet returns empty set when all locations are invalid', () {
    final people = [
      Person(
        id: '3',
        name: Name(last: 'Brown', first: 'Charlie'),
        email: 'charlie.brown@example.com',
        picture: 'https://example.com/charlie.jpg',
        location: Location(latitude: null, longitude: 45.67),
      ),
      Person(
        id: '4',
        name: Name(last: 'White', first: 'Betty'),
        email: 'betty.white@example.com',
        picture: 'https://example.com/betty.jpg',
        location: Location(latitude: 12.34, longitude: null),
      ),
    ];

    final markers = people.toMarkerSet(true, (id) {});

    expect(markers.length, 0);
  });

  test(
      'toMarkerSet returns correct Set<Marker> with mixed valid and invalid locations',
      () {
    final people = [
      Person(
        id: '5',
        name: Name(last: 'Green', first: 'Eve'),
        email: 'eve.green@example.com',
        picture: 'https://example.com/eve.jpg',
        location: Location(latitude: 34.56, longitude: 78.90),
      ),
      Person(
        id: '6',
        name: Name(last: 'Black', first: 'Tom'),
        email: 'tom.black@example.com',
        picture: 'https://example.com/tom.jpg',
        location: Location(latitude: null, longitude: 45.67),
      ),
    ];

    final markers = people.toMarkerSet(true, (id) {});

    expect(markers.length, 1);
    expect(markers.any((marker) => marker.markerId.value == '5'), isTrue);
  });

  test('toMarkerSet handles onTap callback correctly', () {
    final people = [
      Person(
        id: '7',
        name: Name(last: 'Yellow', first: 'Alice'),
        email: 'alice.yellow@example.com',
        picture: 'https://example.com/alice.jpg',
        location: Location(latitude: 45.67, longitude: 89.01),
      ),
    ];

    String? tappedId;
    void onTap(String id) {
      tappedId = id;
    }

    final markers = people.toMarkerSet(true, onTap);

    expect(markers.length, 1);
    final marker = markers.first;

    // Simulate the tap
    marker.infoWindow.onTap?.call();
    expect(tappedId, '7');
  });
}
