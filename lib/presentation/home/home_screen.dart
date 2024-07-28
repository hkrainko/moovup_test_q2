import 'dart:async';

import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/domain/usecases/people_usecase.dart';
import 'package:moovup_test/injectable_config.dart';
import 'package:moovup_test/presentation/home/updated_snack_bar.dart';
import 'package:moovup_test/presentation/people/person_card.dart';
import 'package:moovup_test/presentation/routes/route.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeState();
}

class _HomeState extends State<HomeScreen> {
  late final PeopleUseCase _peopleUseCase = getIt<PeopleUseCase>();

  @override
  void initState() {
    super.initState();
    _peopleUseCase.refresh();
    _peopleUseCase.peopleBoardcast.listen((data) {
      if (data.isNotEmpty) {
        _showFinishBanner();
      }
    });
  }

  Future<void> _refresh() async {
    _peopleUseCase.refresh();
  }

  void _showFinishBanner() {
    ScaffoldMessenger.of(context).showSnackBar(const UpdatedSnackBar());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<List<Person>>(
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
            return RefreshIndicator(
              onRefresh: _refresh,
              child: ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final user = snapshot.data![index];
                  return InkWell(
                    onTap: () {
                      PersonRoute(personId: user.id, $extra: user)
                          .push(context);
                    },
                    child: PersonCard(person: user, showEmail: false),
                  );
                },
              ),
            );
          }
        },
      ),
    );
  }
}
