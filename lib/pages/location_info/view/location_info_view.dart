import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/location_info/bloc/location_info_bloc.dart';
import 'package:intl/intl.dart';

class LocationInfoView extends StatelessWidget {
  const LocationInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    Future<void> _onRefresh() async {
      context.read<LocationInfoBloc>().add(LocationInfoRefresh());
      await context.read<LocationInfoBloc>().stream.firstWhere(
            (element) => element.status != LocationInfoStatus.loading,
          );
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleLocation)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationInfoBloc, LocationInfoState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == LocationInfoStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.locationErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<LocationInfoBloc, LocationInfoState>(
          builder: (context, state) {
            final theme = Theme.of(context);
            final location = state.location;
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
                            location?.name ?? '',
                            style: theme.textTheme.titleLarge,
                          ),
                        ),
                      ),
                      ListTile(
                        leading: const Icon(Icons.location_pin),
                        title: Text(location?.type ?? ''),
                        subtitle: Text(l10n.locationType),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.view_in_ar),
                        title: Text(location?.dimension ?? ''),
                        subtitle: Text(l10n.locationDimension),
                        visualDensity: VisualDensity.compact,
                      ),
                      ListTile(
                        leading: const Icon(Icons.calendar_today),
                        title: Text(
                          location != null
                              ? DateFormat.yMMMd(
                                  Localizations.localeOf(context).languageCode,
                                ).format(location.created)
                              : '',
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),
                  Center(
                    child: (state.status == LocationInfoStatus.failure)
                        ? Text(l10n.locationErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == LocationInfoStatus.initial ||
                            state.location == null)
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
