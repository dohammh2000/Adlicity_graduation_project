import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

import '../widgets/chat_item.dart';

class ChatsScreen extends StatelessWidget {
  ChatsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChatCubit(FirebaseFirestore.instance, FirebaseAuth.instance, FirebaseStorage.instance,)
            ..loadChats(),
      child: Scaffold(
        appBar: _appbar(context),
        body: SafeArea(
          child: SizedBox(
            height: MediaQuery.of(context).size.height,
            child: BlocBuilder<ChatCubit, ChatState>(
              builder: (context, state) {
                if (state is ChatLoading) {
                  return Center(child: CircularProgressIndicator());
                } else if (state is ChatLoaded) {
                  return StreamBuilder<QuerySnapshot>(
                    stream: FirebaseFirestore.instance
                        .collection('chats')
                        .where('senderId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                        .snapshots(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return Center(child: CircularProgressIndicator());
                      }

                      final senderChats = snapshot.data!.docs.map((doc) => Chat.fromDocument(doc)).toList();

                      return StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('chats')
                            .where('receiverId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                            .snapshots(),
                        builder: (context, snapshot) {
                          if (!snapshot.hasData) {
                            return Center(child: CircularProgressIndicator());
                          }

                          final receiverChats = snapshot.data!.docs.map((doc) => Chat.fromDocument(doc)).toList();

                          final chats = [...senderChats, ...receiverChats];

                          return ListView.separated(
                            padding: EdgeInsetsDirectional.only(top: 10),
                            itemCount: chats.length,
                            itemBuilder: (context, index) {
                              final chat = chats[index];
                              final currentUser = FirebaseAuth.instance.currentUser;

                              final isCurrentUserSender =
                                  chat.senderId == currentUser!.uid;
                              final otherUserName = isCurrentUserSender
                                  ? chat.receiverName
                                  : chat.senderName;
                              final otherUserProfileImage = isCurrentUserSender
                                  ? chat.receiverProfileImage
                                  : chat.senderProfileImage;

                              return ChatItem(
                                date: DateFormat.jm()
                                    .format(chat.lastTime.toDate()),
                                name: otherUserName,
                                lastMessage: chat.lastMessage,
                                profileImage: otherUserProfileImage,
                                profileOnTap: () {
                                  // Handle profile tap if needed
                                },
                                tileOnTap: () {
                                  Navigator.pushNamed(
                                    context,
                                    Routes.chatDetailsRoute,
                                    arguments: chat.documentId,
                                  );
                                },
                              );
                            },
                            separatorBuilder: (context, index) => Divider(
                              color: AppColors.primary,
                              height: 1,
                              thickness: 1,
                            ),
                          );
                        },
                      );
                    },
                  );
                } else if (state is ChatError) {
                  return Center(child: Text(state.message));
                } else {
                  return Center(child: Text('No chats available.'));
                }
              },
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => UsersListScreen()),
            );
          },
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  AppBar _appbar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Image.asset(
          IconsAssets.arrowLeft,
          width: 24,
        ),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      title: Text(
        'chats'.tr(),
        style: TextStyle(fontFamily: AppStrings.fontFamily, fontSize: 20),
      ),
      centerTitle: true,
    );
  }
}



class UsersListScreen extends StatelessWidget {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a User'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _firestore.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final users = snapshot.data!.docs;

          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user[
                    'UserName']), // Replace 'profileName' with your actual field name
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user['profileImage']),
                ),
                onTap: () async {
                  final currentUser = FirebaseAuth.instance.currentUser;
                  if (currentUser != null) {
                    // Fetch current user's profile details from the 'users' collection
                    final currentUserDoc = await _firestore
                        .collection('users')
                        .doc(currentUser.uid)
                        .get();

                    if (!currentUserDoc.exists) {
                      // Handle case where current user's document does not exist
                      print("Current user's profile document does not exist.");
                      return;
                    }

                    final senderName = currentUserDoc['UserName'];
                    final senderProfileImage = currentUserDoc['profileImage'];

                    final chatData = {
                      'lastMessage': '',
                      'last_time': Timestamp.now(),
                      'receiverId': user[
                          'id'], // Replace 'id' with your actual field name
                      'receiverName': user[
                          'profileName'], // Replace 'profileName' with your actual field name
                      'receiverProfileImage': user['profileImage'],
                      'senderId': currentUser.uid,
                      'senderName': senderName,
                      'senderProfileImage': senderProfileImage,
                    };

                    // Check if a chat already exists
                    final chatQuery = await _firestore
                        .collection('chats')
                        .where('senderId', isEqualTo: currentUser.uid)
                        .where('receiverId', isEqualTo: user['id'])
                        .get();

                    DocumentReference docRef;
                    if (chatQuery.docs.isEmpty) {
                      // Create a new chat document
                      docRef =
                          await _firestore.collection('chats').add(chatData);
                    } else {
                      // Use existing chat document
                      docRef = chatQuery.docs.first.reference;
                    }

                    Navigator.pushNamed(
                      context,
                      Routes.chatDetailsRoute,
                      arguments: docRef.id,
                    );
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
