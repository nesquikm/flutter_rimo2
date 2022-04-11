import 'package:collection/collection.dart';
import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/character_info/bloc/character_info_bloc.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

class CharacterInfoView extends StatelessWidget {
  const CharacterInfoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Future<void> _onRefresh() async {
      context.read<CharacterInfoBloc>().add(CharacterInfoRefresh());
      await context.read<CharacterInfoBloc>().stream.firstWhere(
            (element) => element.status != CharacterInfoStatus.loading,
          );
    }

    void _onLocationTap(int? id) {
      if (id == null) return;
      context.pushNamed(
        InfoPageName.location.name,
        params: {'page': HomePageName.chat.name, 'id': '$id'},
      );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleCharacter)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<CharacterInfoBloc, CharacterInfoState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == CharacterInfoStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.characterErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<CharacterInfoBloc, CharacterInfoState>(
          builder: (context, state) {
            final theme = Theme.of(context);
            final character = state.character;
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 16),
                        child: Center(
                          child: CircleAvatar(
                            radius: 64,
                            foregroundImage: character != null
                                ? NetworkImage(character.image)
                                : null,
                            child: const Icon(Icons.person, size: 64),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            character?.name ?? '',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.monitor_heart),
                        title: Text(character?.status.name ?? ''),
                        subtitle: Text(l10n.characterStatus),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.android),
                        title: Text(
                          [character?.species, character?.type]
                              .whereNotNull()
                              .whereNot((element) => element == '')
                              .join(', '),
                        ),
                        subtitle: Text(l10n.characterSpecies),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: Icon(
                          character?.gender == CharacterGender.male
                              ? Icons.male
                              : character?.gender == CharacterGender.female
                                  ? Icons.female
                                  : character?.gender ==
                                          CharacterGender.genderless
                                      ? Icons.clear
                                      : Icons.question_mark,
                        ),
                        subtitle: Text(l10n.characterGender),
                        title: Text(character?.gender.name ?? ''),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          character != null
                              ? DateFormat.yMMMd(
                                  Localizations.localeOf(context).languageCode,
                                ).format(character.created)
                              : '',
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_history),
                        title: Text(character?.origin.name ?? ''),
                        subtitle: Text(l10n.characterOriginLocation),
                        onTap: () => _onLocationTap(character?.origin.id),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_pin),
                        title: Text(character?.location.name ?? ''),
                        subtitle: Text(l10n.characterLastKnownLocation),
                        onTap: () => _onLocationTap(character?.location.id),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  Center(
                    child: (state.status == CharacterInfoStatus.failure)
                        ? Text(l10n.characterErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == CharacterInfoStatus.initial ||
                            state.character == null)
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
