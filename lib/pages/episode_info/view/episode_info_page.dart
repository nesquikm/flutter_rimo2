import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/episode_info/bloc/episode_info_bloc.dart';
import 'package:flutter_rimo2/pages/episode_info/view/episode_info_view.dart';

class EpisodeInfoPage extends StatelessWidget {
  const EpisodeInfoPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodeInfoBloc(
        context.read<EntitiesRepository>(),
      )..add(EpisodeInfoFetchById(id: id)),
      child: const EpisodeInfoView(),
    );
  }
}
