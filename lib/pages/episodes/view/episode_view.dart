import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';

class EpisodeView extends StatelessWidget {
  const EpisodeView({super.key, required this.episode, this.onTap});
  final Episode episode;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(episode.name),
      subtitle: Text('${episode.episode}, ${episode.airDate}'),
      onTap: onTap,
    );
  }
}
