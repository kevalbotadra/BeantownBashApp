import 'package:equatable/equatable.dart';

abstract class ItemEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class GetItems extends ItemEvent {}
