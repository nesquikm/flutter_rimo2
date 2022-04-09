import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/character_info/bloc/character_info_bloc.dart';
import 'package:flutter_rimo2/pages/character_info/view/character_info_view.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({Key? key}) : super(key: key);

  static Route<void> route({required int id}) {
    return MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => BlocProvider(
        create: (context) => CharacterInfoBloc(
          context.read<EntitiesRepository>(),
        )..add(CharacterInfoFetchById(id: id)),
        child: const CharacterInfoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CharacterInfoBloc, CharacterInfoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == CharacterInfoStatus.success,
      listener: (context, state) {}, // Navigator.of(context).pop(),
      child: const CharacterInfoView(),
    );
  }
}
