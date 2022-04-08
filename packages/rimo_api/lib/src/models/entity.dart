import 'package:equatable/equatable.dart';

/// Entity prototype
abstract class Entity extends Equatable {
  /// Create explicit entity
  const Entity({
    required this.id,
  });

  /// The id of the entity.
  final int id;
}
