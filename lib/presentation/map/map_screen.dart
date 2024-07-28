import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/usecases/people_usecase.dart';
import 'package:moovup_test/injectable_config.dart';
import 'package:moovup_test/presentation/map/map_view.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final PeopleUseCase _peopleUseCase = getIt<PeopleUseCase>();

  @override
  void initState() {
    super.initState();
    _peopleUseCase.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: _peopleUseCase.peopleBoardcast,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (snapshot.hasError) {
          return Center(
            child: Text('Error: ${snapshot.error}'),
          );
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(
            child: Text('No data available'),
          );
        } else {
          return MapView(people: snapshot.data as List<Person>, allowNav: true);
        }
      },
    );
  }
}
