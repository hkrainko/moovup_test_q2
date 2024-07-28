// UserAdapter
import 'package:hive/hive.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';

class UserAdapter extends TypeAdapter<Person> {
  @override
  final typeId = 2;

  @override
  Person read(BinaryReader reader) {
    return Person(
      id: reader.readString(),
      name: reader.read() as Name,
      email: reader.readString(),
      picture: reader.readString(),
      location: reader.read() as Location,
    );
  }

  @override
  void write(BinaryWriter writer, Person obj) {
    writer.writeString(obj.id);
    writer.write(obj.name);
    writer.writeString(obj.email);
    writer.writeString(obj.picture);
    writer.write(obj.location);
  }
}
