import 'package:moovup_test/data/extensions/location_json.dart';
import 'package:moovup_test/data/extensions/name_json.dart';
import 'package:moovup_test/domain/entities/person.dart';

extension UserJson on Person {
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name.toJson(),
      'email': email,
      'picture': picture,
      'location': location.toJson(),
    };
  }

  static Person fromJson(Map<String, dynamic> json) {
    return Person(
      id: json['_id'],
      name: NameJson.fromJson(json['name']),
      email: json['email'],
      picture: json['picture'],
      location: LocationJson.fromJson(json['location']),
    );
  }
}
