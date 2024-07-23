import 'package:moovup_test/data/data_sources/people_data_source.dart';
import 'package:moovup_test/domain/entities/location.dart';
import 'package:moovup_test/domain/entities/name.dart';
import 'package:moovup_test/domain/entities/user.dart';

class PeopleDummyDataSourceImpl implements PeopleDataSource {
  @override
  Future<List<User>> getPeople() async {
    return [
      User(
          id: '1',
          name: Name(last: 'Smith', first: 'John'),
          email: 'john.smith@example.com',
          picture: '',
          location: Location(latitude: 37.7749, longitude: -122.4194)),
      User(
          id: '2',
          name: Name(last: 'Doe', first: 'Jane'),
          email: 'jane.doe@example.com',
          picture: '',
          location: Location(latitude: 34.0522, longitude: -118.2437)),
      User(
          id: '3',
          name: Name(last: 'Brown', first: 'Charlie'),
          email: 'charlie.brown@example.com',
          picture: '',
          location: Location(latitude: 40.7128, longitude: -74.0060)),
      User(
          id: '4',
          name: Name(last: 'Johnson', first: 'Emily'),
          email: 'emily.johnson@example.com',
          picture: '',
          location: Location(latitude: 51.5074, longitude: -0.1278)),
      User(
          id: '5',
          name: Name(last: 'Williams', first: 'Michael'),
          email: 'michael.williams@example.com',
          picture: '',
          location: Location(latitude: 48.8566, longitude: 2.3522))
    ];
  }
}

class ServerException implements Exception {}
