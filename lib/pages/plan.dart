// plan.dart
import 'package:flutter/material.dart';

class Plan {
  final String title;
  final String description;
  final String actionButtonText;
  final VoidCallback onPressed;

  Plan({
    required this.title,
    required this.description,
    required this.actionButtonText,
    required this.onPressed,
  });
}
