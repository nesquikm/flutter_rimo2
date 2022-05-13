import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/locations/bloc/locations_bloc.dart';
import 'package:flutter_rimo2/pages/locations/view/locations_view.dart';

class LocationsPage extends StatelessWidget {
  const LocationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationsBloc(context.read<EntitiesRepository>())
        ..add(LocationsFetchFirstPage()),
      child: const LocationsView(),
    );
  }
}
