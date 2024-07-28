import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/extensions/person_ext.dart';

extension PeopleExtension on List<Person> {
  Set<Marker> toMarkerSet(bool showArrow, void Function(String)? onTap) {
    return map((p) => p.toMarker(showArrow, () => onTap?.call(p.id)))
        .where((m) => m != null)
        .cast<Marker>()
        .toSet();
  }
}
