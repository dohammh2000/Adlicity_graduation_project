import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:file_picker/file_picker.dart';
part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final FirebaseStorage _storage;

  ChatCubit(this._firestore, this._auth, this._storage) : super(ChatInitial());

  Future<void> loadChats() async {
    emit(ChatLoading());
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(ChatError("User not authenticated"));
        return;
      }

      final QuerySnapshot chatSnapshots = await _firestore
          .collection('chats')
          .where('senderId', isEqualTo: currentUser.uid)
          .get();

      final QuerySnapshot receiverChatsSnapshots = await _firestore
          .collection('chats')
          .where('receiverId', isEqualTo: currentUser.uid)
          .get();

      final List<DocumentSnapshot> allChats = [];
      allChats.addAll(chatSnapshots.docs);
      allChats.addAll(receiverChatsSnapshots.docs);

      final List<Chat> chats =
          allChats.map((doc) => Chat.fromDocument(doc)).toList();

      emit(ChatLoaded(chats));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<void> loadChatDetails(String chatId) async {
    emit(ChatLoading());
    try {
      User? currentUser = _auth.currentUser;
      if (currentUser == null) {
        emit(ChatError("User not authenticated"));
        return;
      }

      final DocumentSnapshot chatDoc =
          await _firestore.collection('chats').doc(chatId).get();
      final chat = Chat.fromDocument(chatDoc);

      emit(ChatDetailsLoaded(chat, currentUser.uid));
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Stream<List<Message>> streamMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: false) // Ensure ascending order
        .snapshots()
        .map((querySnapshot) {
      return querySnapshot.docs
          .map((doc) => Message.fromDocument(doc))
          .toList();
    });
  }

  Future<void> sendMessage(String chatId, String message) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(ChatError("User not authenticated"));
      return;
    }

    try {
      final messageData = {
        'message': message,
        'messageType': 'text',
        'timestamp': Timestamp.now(),
        'uid': currentUser.uid,
      };

      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(messageData);

      // Update the last message info in the parent chat document
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': message,
        'last_time': Timestamp.now(),
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<String> uploadVoiceMessage(File voiceFile) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}.m4a';
      TaskSnapshot snapshot = await _storage
          .ref()
          .child('voice_messages')
          .child(fileName)
          .putFile(voiceFile);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      emit(ChatError(e.toString()));
      return '';
    }
  }

  Future<void> sendVoiceMessage(String chatId, File voiceFile) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(ChatError("User not authenticated"));
      return;
    }

    try {
      String voiceUrl = await uploadVoiceMessage(voiceFile);

      if (voiceUrl.isEmpty) {
        emit(ChatError("Failed to upload voice message"));
        return;
      }

      final messageData = {
        'message': voiceUrl,
        'messageType': 'voice',
        'timestamp': Timestamp.now(),
        'uid': currentUser.uid,
      };

      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(messageData);

      // Update the last message info in the parent chat document
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': '[Voice Message]',
        'last_time': Timestamp.now(),
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }

  Future<String> uploadFile(File file, String folder) async {
    try {
      String fileName = '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
      TaskSnapshot snapshot = await _storage
          .ref()
          .child(folder)
          .child(fileName)
          .putFile(file);
      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      emit(ChatError(e.toString()));
      return '';
    }
  }

  Future<void> sendPdfMessage(String chatId, File pdfFile) async {
    User? currentUser = _auth.currentUser;
    if (currentUser == null) {
      emit(ChatError("User not authenticated"));
      return;
    }

    try {
      String pdfUrl = await uploadFile(pdfFile, 'pdf_documents');

      if (pdfUrl.isEmpty) {
        emit(ChatError("Failed to upload PDF document"));
        return;
      }

      final messageData = {
        'message': pdfUrl,
        'messageType': 'pdf',
        'timestamp': Timestamp.now(),
        'uid': currentUser.uid,
      };

      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(messageData);

      // Update the last message info in the parent chat document
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': '[PDF Document]',
        'last_time': Timestamp.now(),
      });
    } catch (e) {
      emit(ChatError(e.toString()));
    }
  }
}




class Chat {
  final String documentId;
  final String lastMessage;
  final Timestamp lastTime;
  final String receiverId;
  final String receiverName;
  final String receiverProfileImage;
  final String senderId;
  final String senderName;
  final String senderProfileImage;

  Chat({
    required this.documentId,
    required this.lastMessage,
    required this.lastTime,
    required this.receiverId,
    required this.receiverName,
    required this.receiverProfileImage,
    required this.senderId,
    required this.senderName,
    required this.senderProfileImage,
  });

  factory Chat.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Chat(
      documentId: doc.id,
      lastMessage: data['lastMessage'] ?? '',
      lastTime: data['last_time'],
      receiverId: data['receiverId'],
      receiverName: data['receiverName'],
      receiverProfileImage: data['receiverProfileImage'],
      senderId: data['senderId'],
      senderName: data['senderName'],
      senderProfileImage: data['senderProfileImage'],
    );
  }





















}

class Message {
  final String message;
  final String messageType;
  final Timestamp timestamp;
  final String uid;

  Message({
    required this.message,
    required this.messageType,
    required this.timestamp,
    required this.uid,
  });

  factory Message.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Message(
      message: data['message'],
      messageType: data['messageType'] ?? 'text', // default to 'text' if not present
      timestamp: data['timestamp'],
      uid: data['uid'],
    );
  }
}
