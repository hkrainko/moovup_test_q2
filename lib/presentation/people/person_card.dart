import 'package:flutter/material.dart';
import 'package:moovup_test/domain/entities/person.dart';
import 'package:cached_network_image/cached_network_image.dart';

class PersonCard extends StatelessWidget {
  const PersonCard({super.key, required this.person, required this.showEmail});

  final Person person;
  final bool showEmail;

  @override
  Widget build(BuildContext context) {
    final String pictureUrl = person.picture.isNotEmpty
        ? person.picture
        : 'https://via.placeholder.com/150';

    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage:
              CachedNetworkImageProvider(pictureUrl, cacheKey: pictureUrl),
        ),
        title: Text('${person.name.first} ${person.name.last}'),
        subtitle: showEmail ? Text(person.email) : const SizedBox.shrink(),
      ),
    );
  }
}
