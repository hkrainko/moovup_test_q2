import 'package:moovup_test/domain/entities/name.dart';

extension NameJson on Name {
  Map<String, dynamic> toJson() {
    return {
      'first': first,
      'last': last,
    };
  }

  static Name fromJson(Map<String, dynamic> json) {
    return Name(
      first: json['first'],
      last: json['last'],
    );
  }
}
