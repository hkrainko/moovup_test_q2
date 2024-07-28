import 'package:flutter_test/flutter_test.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/presentation/map/extensions/markers_ext.dart';

void main() {
  group('MarkersExtension', () {
    test('getBounds returns correct LatLngBounds for given markers', () async {
      final markers = <Marker>{
        const Marker(
          markerId: MarkerId('1'),
          position: LatLng(10.0, 10.0),
        ),
        const Marker(
          markerId: MarkerId('2'),
          position: LatLng(20.0, 20.0),
        ),
        const Marker(
          markerId: MarkerId('3'),
          position: LatLng(30.0, 30.0),
        ),
      };

      final bounds = markers.getBounds();

      expect(bounds.southwest.latitude, closeTo(10.0 - 0.05, 0.0001));
      expect(bounds.southwest.longitude, closeTo(10.0 - 0.05, 0.0001));
      expect(bounds.northeast.latitude, closeTo(30.0 + 0.05, 0.0001));
      expect(bounds.northeast.longitude, closeTo(30.0 + 0.05, 0.0001));
    });

    test('getBounds returns correct LatLngBounds for identical markers', () {
      final markers = <Marker>{
        const Marker(
          markerId: MarkerId('1'),
          position: LatLng(15.0, 15.0),
        ),
        const Marker(
          markerId: MarkerId('2'),
          position: LatLng(15.0, 15.0),
        ),
      };

      final bounds = markers.getBounds();

      expect(bounds.southwest.latitude, closeTo(15.0 - 0.05, 0.0001));
      expect(bounds.southwest.longitude, closeTo(15.0 - 0.05, 0.0001));
      expect(bounds.northeast.latitude, closeTo(15.0 + 0.05, 0.0001));
      expect(bounds.northeast.longitude, closeTo(15.0 + 0.05, 0.0001));
    });

    test('getBounds handles empty marker set gracefully', () {
      final markers = <Marker>{};

      expect(
        () => markers.getBounds(),
        throwsA(isA<StateError>()),
      );
    });
  });
}
