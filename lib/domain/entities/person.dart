import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';

class Person {
  String id;
  Name name;
  String email;
  String picture;
  Location location;

  Person({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
    required this.location,
  });

  String formattedName() {
    return '${name.first} ${name.last}';
  }

  @override
  String toString() {
    return 'Person(id: $id, name: $name, email: $email, picture: $picture, location: $location)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Person &&
        other.id == id &&
        other.name == name &&
        other.email == email &&
        other.picture == picture &&
        other.location == location;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        name.hashCode ^
        email.hashCode ^
        picture.hashCode ^
        location.hashCode;
  }
}
