import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'info.g.dart';

/// An info class
@JsonSerializable()
class Info extends Equatable {
  /// Create explicit info
  const Info({
    required this.count,
    required this.pages,
    required this.next,
    required this.prev,
  });

  /// Create info from json
  factory Info.fromJson(Map<String, dynamic> json) => _$InfoFromJson(json);

  /// Store info to json
  Map<String, dynamic> toJson() => _$InfoToJson(this);

  /// The length of the response
  final int count;

  /// The amount of pages
  final int pages;

  /// Link to the next page (if it exists)
  final String? next;

  /// Link to the previous page (if it exists)
  final String? prev;

  @override
  List<Object?> get props => [
        count,
        pages,
        next,
        prev,
      ];
}
