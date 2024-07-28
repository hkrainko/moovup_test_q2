import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:moovup_test/presentation/map/map_view.dart';
import 'package:moovup_test/presentation/people/person_card.dart';

class PersonScreen extends StatefulWidget {
  final Person person;

  const PersonScreen({super.key, required this.person});

  @override
  State<PersonScreen> createState() => _PersonScreenState();
}

class _PersonScreenState extends State<PersonScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.person.formattedName()),
      ),
      body: Column(
        children: <Widget>[
          Expanded(child: MapView(people: [widget.person], allowNav: false)),
          PersonCard(person: widget.person, showEmail: true)
        ],
      ),
    );
  }
}
