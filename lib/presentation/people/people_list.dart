import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/user.dart';

class PeopleList extends StatefulWidget {
  const PeopleList({super.key});

  @override
  State<PeopleList> createState() => _PeopleListState();
}

class _PeopleListState extends State<PeopleList> {
  List<User> people = [];

  @override
  void initState() {
    super.initState();
    people = [];
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: people.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(people[index].formattedName()),
        );
      },
    );
  }
}
