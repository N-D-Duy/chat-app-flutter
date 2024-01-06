abstract class ChatState{}

class ChatInitialState extends ChatState{}
class ChatLoadingState extends ChatState{}
class ChatLoadedState extends ChatState{
  final List<Map<String, dynamic>> chats;
  ChatLoadedState({required this.chats});
}
class ChatErrorState extends ChatState{
  final String message;
  ChatErrorState({required this.message});
}
class ChatCreated extends ChatState{}
class ChatUpdated extends ChatState{}
class ChatDeleted extends ChatState{}
