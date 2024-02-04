import 'package:equatable/equatable.dart';

abstract class GetAllContactsState extends Equatable {
  const GetAllContactsState();

  @override
  List<Object> get props => [];
}

class GetAllContactstInitial extends GetAllContactsState {}

class GetAllContactsLoading extends GetAllContactsState {}

class GetAllContactsSuccess extends GetAllContactsState {}

class GetAllContactsError extends GetAllContactsState {
  final String message;

  const GetAllContactsError(this.message);

  @override
  List<Object> get props => [message];
}
