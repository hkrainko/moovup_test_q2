import 'package:hive/hive.dart';
import 'package:moovup_test/domain/entities/name.dart';

class NameAdapter extends TypeAdapter<Name> {
  @override
  final typeId = 0;

  @override
  Name read(BinaryReader reader) {
    return Name(
      first: reader.readString(),
      last: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, Name obj) {
    writer.writeString(obj.first);
    writer.writeString(obj.last);
  }
}
