import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/episode_info/bloc/episode_info_bloc.dart';
import 'package:flutter_rimo2/pages/episode_info/view/episode_info_view.dart';

class EpisodeInfoPage extends StatelessWidget {
  const EpisodeInfoPage({Key? key}) : super(key: key);

  static Route<void> route({required int id}) {
    return MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => BlocProvider(
        create: (context) => EpisodeInfoBloc(
          context.read<EntitiesRepository>(),
        )..add(EpisodeInfoFetchById(id: id)),
        child: const EpisodeInfoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EpisodeInfoBloc, EpisodeInfoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == EpisodeInfoStatus.success,
      listener: (context, state) {}, // Navigator.of(context).pop(),
      child: const EpisodeInfoView(),
    );
  }
}
