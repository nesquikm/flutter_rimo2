import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';

class LocationView extends StatelessWidget {
  const LocationView({Key? key, required this.location, this.onTap})
      : super(key: key);
  final Location location;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(location.name),
      subtitle: Text('${location.type}, dimension: ${location.dimension}'),
      onTap: onTap,
    );
  }
}
