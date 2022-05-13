import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/character_info/bloc/character_info_bloc.dart';
import 'package:flutter_rimo2/pages/character_info/view/character_info_view.dart';

class CharacterInfoPage extends StatelessWidget {
  const CharacterInfoPage({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharacterInfoBloc(
        context.read<EntitiesRepository>(),
      )..add(CharacterInfoFetchById(id: id)),
      child: const CharacterInfoView(),
    );
  }
}
