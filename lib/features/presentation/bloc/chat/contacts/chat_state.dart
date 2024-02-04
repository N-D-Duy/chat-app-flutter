part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();
  @override
  List<Object?> get props => [];
}

class ChatInitialState extends ChatState {}

class ChatLoadingState extends ChatState {}

//Chat
class GetAllChatContactsSuccess<T> extends ChatState {
  final T data;
  const GetAllChatContactsSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ChatError extends ChatState {
  final String message;
  const ChatError({required this.message});

  @override
  List<Object?> get props => [message];
}

class GetNumberOfUnreadMessagesSuccess<T> extends ChatState {
  final T data;
  const GetNumberOfUnreadMessagesSuccess({required this.data});

  @override
  List<Object?> get props => [data];
}

class ChatCreatedSuccess extends ChatState {}

class ChatDeletedSuccess extends ChatState {}
