import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/characters/bloc/characters_bloc.dart';
import 'package:flutter_rimo2/pages/characters/view/character_view.dart';

class CharactersView extends StatelessWidget {
  const CharactersView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final _scrollController = ScrollController();

    bool _isBottom() {
      if (!_scrollController.hasClients) return false;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll >= (maxScroll * 0.9);
    }

    void _onScroll() {
      if (_isBottom() && !context.read<CharactersBloc>().state.fetchedAll) {
        context.read<CharactersBloc>().add(const CharactersFetchNextPage());
      }
    }

    void _onTap(int id) {
      // Navigator.of(context).push(
      //   CharacterInfoPage.route(
      //     id: id,
      //   ),
      // );
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<CharactersBloc>().add(CharactersReset());
      await context
          .read<CharactersBloc>()
          .stream
          .firstWhere((element) => element.status != CharactersStatus.loading);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleCharacters)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CharactersBloc, CharactersState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CharactersStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.charactersErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<CharactersBloc, CharactersState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.characters.length +
                        ((!state.fetchedAll && state.characters.isNotEmpty)
                            ? 1
                            : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.characters.length) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final character = state.characters.elementAt(index);
                      return CharacterView(
                        character: character,
                        onTap: () => _onTap(character.id),
                      );
                    },
                    controller: _scrollController,
                  ),
                  Center(
                    child: (state.status == CharactersStatus.failure)
                        ? Text(l10n.charactersErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == CharactersStatus.initial ||
                            state.characters.isEmpty)
                        ? const CircularProgressIndicator()
                        : null,
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
