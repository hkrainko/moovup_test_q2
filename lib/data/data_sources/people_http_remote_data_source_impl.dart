import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:injectable/injectable.dart';

import 'package:moovup_test/data/data_sources/people_remote_data_source.dart';
import 'package:moovup_test/data/extensions/user_json.dart';
import 'package:moovup_test/domain/entities/person.dart';

@Environment(Environment.prod)
@Injectable(as: PeopleRemoteDataSource)
class PeopleHttpRemoteDataSourceImpl implements PeopleRemoteDataSource {
  final http.Client _client;
  final String _bearerToken;
  static const _domain = 'api.json-generator.com';

  PeopleHttpRemoteDataSourceImpl(
      this._client, @Named('BearerToken') this._bearerToken);

  @override
  Future<List<Person>> getPeople() async {
    var url = Uri.https(_domain, '/templates/-xdNcNKYtTFG/data');

    var response = await _client.get(url, headers: {
      'Authorization': 'Bearer $_bearerToken',
    });
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body) as List<dynamic>;

      return jsonResponse.map((e) => UserJson.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }
}

class ServerException implements Exception {}
