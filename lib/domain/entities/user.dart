import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';

class User {
  String id;
  Name name;
  String email;
  String picture;
  Location location;

  User({
    required this.id,
    required this.name,
    required this.email,
    required this.picture,
    required this.location,
  });

  String formattedName() {
    return '${name.first} ${name.last}';
  }
}
