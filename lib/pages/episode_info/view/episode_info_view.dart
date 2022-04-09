import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/episode_info/bloc/episode_info_bloc.dart';
import 'package:intl/intl.dart';

class EpisodeInfoView extends StatelessWidget {
  const EpisodeInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Future<void> _onRefresh() async {
      context.read<EpisodeInfoBloc>().add(EpisodeInfoRefresh());
      await context.read<EpisodeInfoBloc>().stream.firstWhere(
            (element) => element.status != EpisodeInfoStatus.loading,
          );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleEpisode)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<EpisodeInfoBloc, EpisodeInfoState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == EpisodeInfoStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.episodeErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<EpisodeInfoBloc, EpisodeInfoState>(
          builder: (context, state) {
            final theme = Theme.of(context);
            final episode = state.episode;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            episode?.name ?? '',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.live_tv),
                        title: Text(episode?.airDate ?? ''),
                        subtitle: Text(l10n.episodeAirDate),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.code),
                        title: Text(episode?.episode ?? ''),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          episode != null
                              ? DateFormat.yMMMd(
                                  Localizations.localeOf(context).languageCode,
                                ).format(episode.created)
                              : '',
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  Center(
                    child: (state.status == EpisodeInfoStatus.failure)
                        ? Text(l10n.episodeErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == EpisodeInfoStatus.initial ||
                            state.episode == null)
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
