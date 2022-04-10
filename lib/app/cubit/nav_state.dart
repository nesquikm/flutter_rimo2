part of 'nav_cubit.dart';

@JsonSerializable()
class NavState extends Equatable {
  const NavState(this.location);

  factory NavState.fromJson(Map<String, dynamic> json) =>
      _$NavStateFromJson(json);

  Map<String, dynamic> toJson() => _$NavStateToJson(this);

  final String location;

  @override
  List<Object> get props => [location];
}
