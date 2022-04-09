import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/episodes/bloc/episodes_bloc.dart';
import 'package:flutter_rimo2/pages/episodes/view/episode_view.dart';
import 'package:go_router/go_router.dart';

class EpisodesView extends StatelessWidget {
  const EpisodesView({Key? key}) : super(key: key);

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
      if (_isBottom() && !context.read<EpisodesBloc>().state.fetchedAll) {
        context.read<EpisodesBloc>().add(const EpisodesFetchNextPage());
      }
    }

    void _onTap(int id) {
      context.goNamed('episode', params: {'page': 'episodes', 'id': '$id'});
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<EpisodesBloc>().add(EpisodesReset());
      await context
          .read<EpisodesBloc>()
          .stream
          .firstWhere((element) => element.status != EpisodesStatus.loading);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleEpisodes)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EpisodesBloc, EpisodesState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == EpisodesStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.episodesErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<EpisodesBloc, EpisodesState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.episodes.length +
                        ((!state.fetchedAll && state.episodes.isNotEmpty)
                            ? 1
                            : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.episodes.length &&
                          state.episodes.isNotEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final episode = state.episodes.elementAt(index);
                      return EpisodeView(
                        episode: episode,
                        onTap: () => _onTap(episode.id),
                      );
                    },
                    controller: _scrollController,
                  ),
                  Center(
                    child: (state.status == EpisodesStatus.failure)
                        ? Text(l10n.episodesErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == EpisodesStatus.initial)
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
