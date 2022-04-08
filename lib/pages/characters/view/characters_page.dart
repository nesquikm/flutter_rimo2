import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_rimo2/pages/characters/view/characters_view.dart';

class CharactersPage extends StatelessWidget {
  const CharactersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CharactersBloc(context.read<EntitiesRepository>())
        ..add(CharactersFetchFirstPage()),
      child: const CharactersView(),
    );
  }
}
