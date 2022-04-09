import 'package:entities_repository/entities_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rimo2/pages/location_info/bloc/location_info_bloc.dart';
import 'package:flutter_rimo2/pages/location_info/view/location_info_view.dart';

class LocationInfoPage extends StatelessWidget {
  const LocationInfoPage({Key? key}) : super(key: key);

  static Route<void> route({required int id}) {
    return MaterialPageRoute(
      fullscreenDialog: false,
      builder: (context) => BlocProvider(
        create: (context) => LocationInfoBloc(
          context.read<EntitiesRepository>(),
        )..add(LocationInfoFetchById(id: id)),
        child: const LocationInfoPage(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LocationInfoBloc, LocationInfoState>(
      listenWhen: (previous, current) =>
          previous.status != current.status &&
          current.status == LocationInfoStatus.success,
      listener: (context, state) {}, // Navigator.of(context).pop(),
      child: const LocationInfoView(),
    );
  }
}
