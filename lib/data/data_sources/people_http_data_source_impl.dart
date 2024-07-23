import 'dart:convert';
import 'package:http/http.dart';

import 'package:moovup_test/data/data_sources/people_data_source.dart';
import 'package:moovup_test/data/extensions/user_json.dart';
import 'package:moovup_test/domain/entities/user.dart';

class PeopleHttpDataSourceImpl implements PeopleDataSource {
  // final HttpClient client;

  // PeopleHttpDataSourceImpl({required this.client});
  static const _domain = 'https://api.json-generator.com';

  @override
  Future<List<User>> getPeople() async {
    var url = Uri.https(_domain, '/templates/-xdNcNKYtTFG/data');

    var response = await get(url);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as Map<String, dynamic>;

      return (jsonResponse['data'] as List)
          .map((e) => UserJson.fromJson(e))
          .toList();
    } else {
      throw ServerException();
    }
  }
}

class ServerException implements Exception {}
