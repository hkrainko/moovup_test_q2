import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/domain/entities/person.dart';

extension PersonExtension on Person {
  Marker? toMarker(bool showArrow, void Function()? onTap) {
    if (location.latitude == null || location.longitude == null) {
      return null;
    }
    var title = formattedName();
    if (showArrow) {
      title += '→';
    }
    return Marker(
      markerId: MarkerId(id),
      position: LatLng(location.latitude!, location.longitude!),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      infoWindow: InfoWindow(title: title, onTap: onTap),
    );
  }
}
