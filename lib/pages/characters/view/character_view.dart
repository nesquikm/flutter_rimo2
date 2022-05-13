import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';

class CharacterView extends StatelessWidget {
  const CharacterView({
    super.key,
    required this.character,
    this.onTap,
  });
  final Character character;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      leading: CircleAvatar(
        foregroundImage: NetworkImage(character.image),
        child: const Icon(Icons.person, size: 24),
      ),
      title: Text(character.name),
      subtitle: Text('${character.species}, ${character.gender.name}'),
    );
  }
}
