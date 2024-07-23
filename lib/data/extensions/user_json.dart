import 'package:moovup_test/data/extensions/location_json.dart';
import 'package:moovup_test/data/extensions/name_json.dart';
import 'package:moovup_test/domain/entities/user.dart';

extension UserJson on User {
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name.toJson(),
      'email': email,
      'picture': picture,
      'location': location.toJson(),
    };
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
      id: json['_id'],
      name: NameJson.fromJson(json['name']),
      email: json['email'],
      picture: json['picture'],
      location: LocationJson.fromJson(json['location']),
    );
  }
}
