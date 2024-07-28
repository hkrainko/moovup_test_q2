import 'package:google_maps_flutter/google_maps_flutter.dart';

extension MarkersExtension on Set<Marker> {
  LatLngBounds getBounds() {
    double minLat = first.position.latitude;
    double maxLat = first.position.latitude;
    double minLng = first.position.longitude;
    double maxLng = first.position.longitude;
    const double padding = 0.05;

    for (final marker in this) {
      if (marker.position.latitude < minLat) {
        minLat = marker.position.latitude;
      }
      if (marker.position.latitude > maxLat) {
        maxLat = marker.position.latitude;
      }
      if (marker.position.longitude < minLng) {
        minLng = marker.position.longitude;
      }
      if (marker.position.longitude > maxLng) {
        maxLng = marker.position.longitude;
      }
    }

    return LatLngBounds(
      southwest: LatLng(minLat - padding, minLng - padding),
      northeast: LatLng(maxLat + padding, maxLng + padding),
    );
  }
}
