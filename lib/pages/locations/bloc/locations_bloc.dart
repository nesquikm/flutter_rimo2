import 'dart:developer';

import 'package:entities_repository/entities_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_rimo2/pages/utils/throttle_droppable.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:json_annotation/json_annotation.dart';

part 'locations_bloc.g.dart';
part 'locations_event.dart';
part 'locations_state.dart';

class LocationsBloc extends HydratedBloc<LocationsEvent, LocationsState>
    with ThrottleDroppable {
  LocationsBloc(EntitiesRepository entitiesRepository)
      : _apiLocation = entitiesRepository.apiLocation,
        super(LocationsInitial()) {
    on<LocationsReset>(
      (event, emit) {
        add(const LocationsFetchNextPage(reset: true));
      },
    );

    on<LocationsFetchFirstPage>(
      (event, emit) {
        if (state.locations.isEmpty) {
          add(const LocationsFetchNextPage());
        }
      },
    );

    on<LocationsFetchNextPage>(
      _fetchNextPage,
      transformer: throttleDroppable(),
    );
  }

  @override
  LocationsState? fromJson(Map<String, dynamic> json) =>
      LocationsState.fromJson(json);

  @override
  Map<String, dynamic> toJson(LocationsState state) => state.toJson();

  final ApiLocation _apiLocation;

  Future<void> _fetchNextPage(
    LocationsFetchNextPage event,
    Emitter<LocationsState> emit,
  ) async {
    log('==== ${state.fetchedAll} ${state.locations.length} ${event.reset}');
    try {
      if (state.fetchedAll && !event.reset) {
        return;
      }
      emit(
        state.copyWith(
          status: LocationsStatus.loading,
        ),
      );
      if (event.reset) {
        final page = await _apiLocation.getAllLocations();
        emit(
          state.copyWith(
            status: LocationsStatus.success,
            locations: page.entities,
            lastPage: page,
          ),
        );
      } else {
        final page =
            await _apiLocation.getAllLocations(prevPage: state.lastPage);
        emit(
          state.copyWith(
            status: LocationsStatus.success,
            locations: [...state.locations, ...page.entities],
            lastPage: page,
          ),
        );
      }
    } catch (_) {
      emit(state.copyWith(status: LocationsStatus.failure));
    }
  }
}
