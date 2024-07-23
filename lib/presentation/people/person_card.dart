import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/user.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.person});

  final User person;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(person.picture),
        ),
        title: Text('${person.name.first} ${person.name.last}'),
        subtitle: Text(person.email),
      ),
    );
  }
}
