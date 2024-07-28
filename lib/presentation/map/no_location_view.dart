import 'package:flutter/material.dart';

class NoLocationView extends StatelessWidget {
  const NoLocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'No location data available',
        style: Theme.of(context).textTheme.labelLarge,
      ),
    );
  }
}
