import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/mockito.dart';
import 'package:moovup_test/data/data_sources/people_http_remote_data_source_impl.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/injectable_config.dart';

import 'people_http_remote_data_source_impl_test.mocks.dart';

@GenerateNiceMocks([MockSpec<http.Client>()])
void main() {
  late MockClient mockClient;
  late PeopleHttpRemoteDataSourceImpl peopleHttpDataSourceImpl;

  const jsonString = '''[
    {
        "_id": "ae736d8f-5a08-4bab-8e30-1eb2079e5dc2",
        "name": {
            "last": "Bass",
            "first": "Bradley"
        },
        "email": "aida.griffith@sybixtex.show",
        "picture": "https://placebear.com/225/210",
        "location": {
            "latitude": 22.38,
            "longitude": null
        }
    },
    {
        "_id": "ae61bba4-4110-45a7-84c5-ab1c08a86a1d",
        "name": {
            "last": "Calhoun",
            "first": "Amparo"
        },
        "email": "sue.patterson@exoteric.press",
        "picture": "https://placebear.com/60/121",
        "location": {
            "latitude": 22.37,
            "longitude": 113.34
        }
    },
    {
        "_id": "86615bf5-9815-4f70-8ade-a76d2a6c3d56",
        "name": {
            "last": "Allen",
            "first": "Celina"
        },
        "email": "lula.dillard@syntac.pn",
        "picture": "https://placebear.com/85/236",
        "location": {
            "latitude": 22.35,
            "longitude": null
        }
    }
]''';

  setUp(() {
    mockClient = MockClient();
    peopleHttpDataSourceImpl =
        PeopleHttpRemoteDataSourceImpl(mockClient, 'dummy_token');
  });

  tearDown(() {
    getIt.reset();
  });

  final people = [
    Person(
      id: 'ae736d8f-5a08-4bab-8e30-1eb2079e5dc2',
      name: Name(last: 'Bass', first: 'Bradley'),
      email: 'aida.griffith@sybixtex.show',
      picture: 'https://placebear.com/225/210',
      location: Location(latitude: 22.38, longitude: null),
    ),
    Person(
      id: 'ae61bba4-4110-45a7-84c5-ab1c08a86a1d',
      name: Name(last: 'Calhoun', first: 'Amparo'),
      email: 'sue.patterson@exoteric.press',
      picture: 'https://placebear.com/60/121',
      location: Location(latitude: 22.37, longitude: 113.34),
    ),
    Person(
      id: '86615bf5-9815-4f70-8ade-a76d2a6c3d56',
      name: Name(last: 'Allen', first: 'Celina'),
      email: 'lula.dillard@syntac.pn',
      picture: 'https://placebear.com/85/236',
      location: Location(latitude: 22.35, longitude: null),
    ),
  ];

  test('should return a list of people when status code is 200', () async {
    const domain = 'api.json-generator.com';
    var url = Uri.https(domain, '/templates/-xdNcNKYtTFG/data');

    when(mockClient.get(url, headers: {
      'Authorization': 'Bearer dummy_token',
    })).thenAnswer((_) async => http.Response(jsonString, 200));

    final result = await peopleHttpDataSourceImpl.getPeople();

    expect(result, equals(people));
  });
}
