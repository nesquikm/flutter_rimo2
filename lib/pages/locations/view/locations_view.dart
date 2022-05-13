import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/l10n/l10n.dart';
import 'package:flutter_rimo2/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_rimo2/pages/locations/view/location_view.dart';
import 'package:flutter_rimo2/pages/pages.dart';
import 'package:go_router/go_router.dart';

class LocationsView extends StatefulWidget {
  const LocationsView({super.key});

  @override
  State<LocationsView> createState() => _LocationsViewState();
}

class _LocationsViewState extends State<LocationsView> {
  late final ScrollController _scrollController;
  @override
  void initState() {
    super.initState();

    _scrollController = ScrollController();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    bool _isBottom() {
      if (!_scrollController.hasClients) return false;
      final maxScroll = _scrollController.position.maxScrollExtent;
      final currentScroll = _scrollController.offset;
      return currentScroll >= (maxScroll * 0.9);
    }

    void _onScroll() {
      if (_isBottom() && !context.read<LocationsBloc>().state.fetchedAll) {
        context.read<LocationsBloc>().add(const LocationsFetchNextPage());
      }
    }

    void _onTap(int id) {
      context.goNamed(
        InfoPageName.location.name,
        params: {'page': HomePageName.locations.name, 'id': '$id'},
      );
    }

    _scrollController.addListener(_onScroll);

    Future<void> _onRefresh() async {
      context.read<LocationsBloc>().add(LocationsReset());
      await context
          .read<LocationsBloc>()
          .stream
          .firstWhere((element) => element.status != LocationsStatus.loading);
    }

    return Scaffold(
      appBar: AppBar(title: Text(l10n.appBarTitleLocations)),
      body: MultiBlocListener(
        listeners: [
          BlocListener<LocationsBloc, LocationsState>(
            listenWhen: (previous, current) =>
                previous.status != current.status,
            listener: (context, state) {
              if (state.status == LocationsStatus.failure) {
                ScaffoldMessenger.of(context)
                  ..hideCurrentSnackBar()
                  ..showSnackBar(
                    SnackBar(
                      content: Text(l10n.locationsErrorSnackbarText),
                    ),
                  );
              }
            },
          ),
        ],
        child: BlocBuilder<LocationsBloc, LocationsState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: _onRefresh,
              child: Stack(
                children: [
                  ListView.builder(
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemCount: state.locations.length +
                        ((!state.fetchedAll && state.locations.isNotEmpty)
                            ? 1
                            : 0),
                    itemBuilder: (BuildContext context, int index) {
                      if (index == state.locations.length &&
                          state.locations.isNotEmpty) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      final location = state.locations.elementAt(index);
                      return LocationView(
                        location: location,
                        onTap: () => _onTap(location.id),
                      );
                    },
                    controller: _scrollController,
                  ),
                  Center(
                    child: (state.status == LocationsStatus.failure)
                        ? Text(l10n.locationsErrorSnackbarText)
                        : null,
                  ),
                  Center(
                    child: (state.status == LocationsStatus.initial)
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
