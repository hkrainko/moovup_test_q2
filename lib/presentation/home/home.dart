import 'package:flutter/material.dart';
import 'package:moovup_test/data/data_sources/people_dummy_data_source_impl.dart';
import 'package:moovup_test/data/data_sources/people_http_data_source_impl.dart';
import 'package:moovup_test/data/repositories/people_repository_impl.dart';
import 'package:moovup_test/domain/entities/user.dart';
import 'package:moovup_test/domain/usecases/people_usecase.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late final PeopleUseCase _peopleUseCase;

  @override
  void initState() {
    super.initState();

    var peopleDataSource = PeopleDummyDataSourceImpl();
    var peopleRepository = PeopleRepositoryImpl(peopleDataSource);
    _peopleUseCase = PeopleUseCase(peopleRepository);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
      ),
      body: FutureBuilder<List<User>>(
        future: _peopleUseCase.getPeople(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final user = snapshot.data![index];
                return ListTile(
                  title: Text(user.formattedName()),
                  subtitle: Text(user.email),
                );
              },
            );
          }
        },
      ),
    );
  }
}
