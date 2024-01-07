abstract class ChatState{}

class ChatInitialState extends ChatState{}
class ChatLoadingState extends ChatState{}
class ChatLoadedState<T> extends ChatState{
  final T data;
  ChatLoadedState({required this.data});
}
class ChatErrorState extends ChatState{
  final String message;
  ChatErrorState({required this.message});
}
class ChatCreated extends ChatState{}
class ChatUpdated extends ChatState{}
class ChatDeleted extends ChatState{}
