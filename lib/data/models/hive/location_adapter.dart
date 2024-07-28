// LocationAdapter
import 'package:hive/hive.dart';
import 'package:moovup_test/domain/entities/location.dart';

class LocationAdapter extends TypeAdapter<Location> {
  @override
  final typeId = 1;

  @override
  Location read(BinaryReader reader) {
    double? latitude;
    double? longitude;

    if (reader.readBool() == false) {
      latitude = null;
    } else {
      latitude = reader.readDouble();
    }

    if (reader.readBool() == false) {
      longitude = null;
    } else {
      longitude = reader.readDouble();
    }

    return Location(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  void write(BinaryWriter writer, Location obj) {
    if (obj.latitude == null) {
      writer.writeBool(false);
      writer.writeDouble(0);
    } else {
      writer.writeBool(true);
      writer.writeDouble(obj.latitude!);
    }

    if (obj.longitude == null) {
      writer.writeBool(false);
      writer.writeDouble(0);
    } else {
      writer.writeBool(true);
      writer.writeDouble(obj.longitude!);
    }
  }
}
