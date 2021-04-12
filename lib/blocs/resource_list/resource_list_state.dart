import 'package:bro/models/resource.dart';
import 'package:equatable/equatable.dart';

abstract class ResourceListState extends Equatable {
  ResourceListState();

  @override
  List<Object> get props => [];
}

class Loading extends ResourceListState {}

class Success extends ResourceListState {
  final Data resources;

  Success({required this.resources});

  @override
  List<Object> get props => [resources];

  @override
  String toString() => 'Success { data: $resources }';
}

class Failed extends ResourceListState {
  final String err;
  Failed({required this.err});

  @override
  List<Object> get props => [err];
}
