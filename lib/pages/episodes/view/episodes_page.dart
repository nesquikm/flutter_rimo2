import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_rimo2/pages/episodes/view/episodes_view.dart';

class EpisodesPage extends StatelessWidget {
  const EpisodesPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EpisodesBloc(context.read<EntitiesRepository>())
        ..add(EpisodesFetchFirstPage()),
      child: const EpisodesView(),
    );
  }
}
