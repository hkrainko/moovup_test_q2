import 'package:flutter/material.dart';

class UpdatedSnackBar extends SnackBar {
  // const UpdatedSnackBar({super.key});

  const UpdatedSnackBar({super.key})
      : super(
          content: const Row(
            children: [
              Icon(Icons.check, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Data updated',
                textAlign: TextAlign.start,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          backgroundColor: Colors.green,
          behavior: SnackBarBehavior.floating,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          duration: const Duration(seconds: 2),
        );
}
