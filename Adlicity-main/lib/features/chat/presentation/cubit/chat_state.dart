part of 'chat_cubit.dart';

abstract class ChatState extends Equatable {
  const ChatState();

  @override
  List<Object> get props => [];
}



class ChatInitial extends ChatState {}

class ChatLoading extends ChatState {}



class MessagesLoaded extends ChatState {
  final List<Message> messages;

  MessagesLoaded(this.messages);

  @override
  List<Object> get props => [messages];
}




//////////////////////////////////////
class ChatLoaded extends ChatState {
  final List<Chat> chats;
  final String receiverName;
  final String receiverProfileImage;

  const ChatLoaded(this.chats, {this.receiverName = '', this.receiverProfileImage = ''});

  @override
  List<Object> get props => [chats, receiverName, receiverProfileImage];
}


class ChatDetailsLoaded extends ChatState {
  final Chat chat;
  final String currentUserId;

  ChatDetailsLoaded(this.chat, this.currentUserId);
}





class ChatCreated extends ChatState {
  final String chatId;

  const ChatCreated(this.chatId);

  @override
  List<Object> get props => [chatId];
}


class ChatError extends ChatState {
  final String message;

  ChatError(this.message);

  @override
  List<Object> get props => [message];
}

