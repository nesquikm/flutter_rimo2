import 'package:equatable/equatable.dart';
import 'package:rimo_api/src/models/models.dart';

/// {@template page}
/// Page includes Info and list of entities
/// {@endtemplate}
abstract class Page<E extends Entity> extends Equatable {
  /// {@macro page}
  const Page(this.info, this.entities);

  /// An info object
  final Info info;

  /// A list of entities
  final List<E> entities;
}
