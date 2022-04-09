import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/location_info/bloc/location_info_bloc.dart';
import 'package:flutter_rimo2/pages/location_info/view/location_info_view.dart';

class LocationInfoPage extends StatelessWidget {
  const LocationInfoPage({Key? key, required this.id}) : super(key: key);

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationInfoBloc(
        context.read<EntitiesRepository>(),
      )..add(LocationInfoFetchById(id: id)),
      child: const LocationInfoView(),
    );
  }
}
