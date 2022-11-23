import 'package:flutter/material.dart';

class MainCard extends StatelessWidget {
  const MainCard({
    required this.backgroundColor,
    required this.child,
    Key? key,
  }) : super(key: key);

  final Color backgroundColor;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(16.0),
        ),
      ),
      color: backgroundColor,
      child: child,
    );
  }
}
