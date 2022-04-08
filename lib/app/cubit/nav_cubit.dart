import 'package:equatable/equatable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'nav_cubit.g.dart';
part 'nav_state.dart';

class NavCubit extends HydratedCubit<NavState> {
  NavCubit(String location) : super(NavState(location));

  void setLocation(String location) => emit(NavState(location));

  @override
  NavState? fromJson(Map<String, dynamic> json) => NavState.fromJson(json);

  @override
  Map<String, dynamic>? toJson(NavState state) => state.toJson();
}
