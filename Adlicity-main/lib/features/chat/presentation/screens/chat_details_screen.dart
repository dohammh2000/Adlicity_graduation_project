import 'dart:convert';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/input_field.dart';
import 'package:adlicity/core/widgets/rating_dialog.dart';
import 'package:adlicity/core/widgets/report_dialog.dart';
import 'package:adlicity/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_sound/public/flutter_sound_player.dart';
import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:gap/gap.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/appbar_circle_button.dart';

class ChatDetailsScreen extends StatelessWidget {
  final String chatId;

  const ChatDetailsScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ChatCubit(
        FirebaseFirestore.instance,
        FirebaseAuth.instance,
        FirebaseStorage.instance,
      )..loadChatDetails(chatId),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is ChatDetailsLoaded) {
            final chat = state.chat;
            final isCurrentUserSender = chat.senderId == state.currentUserId;
            final otherUserName =
                isCurrentUserSender ? chat.receiverName : chat.senderName;
            final otherUserProfileImage = isCurrentUserSender
                ? chat.receiverProfileImage
                : chat.senderProfileImage;

            return ChatDetailsView(
              chatId: chatId,
              receiverName: otherUserName,
              receiverProfileImage: otherUserProfileImage,
            );
          } else if (state is ChatLoading) {
            return Scaffold(
              appBar: AppBar(title: Text('Loading...')),
              body: Center(child: CircularProgressIndicator()),
            );
          } else if (state is ChatError) {
            return Scaffold(
              appBar: AppBar(title: Text('Error')),
              body: Center(child: Text('Error loading chat: ${state.message}')),
            );
          } else {
            return Scaffold(
              appBar: AppBar(title: Text('No Chat Available')),
              body: Center(child: Text('No chat available')),
            );
          }
        },
      ),
    );
  }
}

class ChatDetailsView extends StatefulWidget {
  final String chatId;
  final String receiverName;
  final String receiverProfileImage;

  ChatDetailsView({
    super.key,
    required this.chatId,
    required this.receiverName,
    required this.receiverProfileImage,
  });

  @override
  _ChatDetailsViewState createState() => _ChatDetailsViewState();
}

class _ChatDetailsViewState extends State<ChatDetailsView> {
  final TextEditingController _messageController = TextEditingController();
  FlutterSoundRecorder? _recorder;
  bool _isRecording = false;
  late Directory _tempDir;

  @override
  void initState() {
    super.initState();
    _initializeRecorder();
    _initializeTempDir();
  }

  Future<void> _initializeRecorder() async {
    _recorder = FlutterSoundRecorder();
    await _recorder!.openRecorder();
    await Permission.microphone.request();
  }

  Future<void> _initializeTempDir() async {
    _tempDir = await getTemporaryDirectory();
  }

  Future<void> _startRecording() async {
    if (!_isRecording && _recorder!.isStopped) {
      String path = '${_tempDir.path}/voice_message.aac';
      await _recorder!.startRecorder(toFile: path);
      setState(() {
        _isRecording = true;
      });
    }
  }

  Future<void> _stopRecording(BuildContext context) async {
    if (_isRecording && _recorder!.isRecording) {
      String? path = await _recorder!.stopRecorder();
      setState(() {
        _isRecording = false;
      });
      if (path != null) {
        File voiceFile = File(path);
        context.read<ChatCubit>().sendVoiceMessage(widget.chatId, voiceFile);
      }
    }
  }

  Future<void> _pickAndSendPdf() async {
    FilePickerResult? result = await FilePicker.platform
        .pickFiles(type: FileType.custom, allowedExtensions: ['pdf']);
    if (result != null && result.files.single.path != null) {
      File pdfFile = File(result.files.single.path!);
      context.read<ChatCubit>().sendPdfMessage(widget.chatId, pdfFile);
    }
  }

  @override
  void dispose() {
    _recorder?.closeRecorder();
    _messageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatCubit = context.read<ChatCubit>();

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar:
          _appbar(context, widget.receiverName, widget.receiverProfileImage),
      body: Column(
        children: <Widget>[
          Flexible(
            child: StreamBuilder<List<Message>>(
              stream: chatCubit.streamMessages(widget.chatId),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error loading messages'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No messages'));
                } else {
                  final messages = snapshot.data!;
                  return ListView.builder(
                    padding: EdgeInsets.all(8.0),
                    reverse: false,
                    itemCount: messages.length,
                    itemBuilder: (_, int index) {
                      final message = messages[index];
                      return MessageItem(
                        isSender: message.uid ==
                            FirebaseAuth.instance.currentUser!.uid,
                        date:
                            DateFormat.jm().format(message.timestamp.toDate()),
                        isTail: false,
                        message: message.message,
                        messageType: message.messageType,
                      );
                    },
                  );
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsetsDirectional.only(
              top: 10,
              start: Constants.kPadding,
              end: Constants.kPadding,
              bottom: 10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: MediaQuery.of(context).size.width *
                      0.5, // Adjust width as needed
                  child: InputField(
                    controller: _messageController,
                    hintText: 'type_message'.tr(),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(12),
                  onPressed: _pickAndSendPdf,
                  icon: Icon(
                    Icons.attach_file,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(12),
                  onPressed: () {
                    final messageText = _messageController.text.trim();
                    if (messageText.isNotEmpty) {
                      chatCubit.sendMessage(widget.chatId, messageText);
                      _messageController.clear();
                    }
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary),
                  ),
                ),
                IconButton(
                  padding: EdgeInsets.all(12),
                  onPressed: _isRecording
                      ? () => _stopRecording(context)
                      : _startRecording,
                  icon: Icon(
                    _isRecording ? Icons.stop : Icons.mic,
                    color: Colors.white,
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all(AppColors.primary),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  AppBar _appbar(
      BuildContext context, String receiverName, String receiverProfileImage) {
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
      centerTitle: false,
      titleSpacing: 0,
      title: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(receiverProfileImage),
              radius: 15,
            ),
            SizedBox(width: 10),
            Text(
              receiverName,
              style: TextStyle(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                fontFamily: AppStrings.fontFamily,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      actions: [
        AppbarCircleButton(
          image: IconsAssets.starOutline,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => RateDialog(
                profileName: receiverName,
                profileImage: receiverProfileImage,
                userId: '',
              ),
            );
          },
        ),
        AppbarCircleButton(
          image: IconsAssets.reportOutline,
          onTap: () {
            showDialog(
              context: context,
              builder: (context) => ReportDialog(
                profileName: receiverName,
                profileImage: receiverProfileImage,
              ),
            );
          },
        ),
        SizedBox(width: Constants.kPadding),
      ],
    );
  }
}

class MessageItem extends StatefulWidget {
  final bool isSender;
  final bool isTail;
  final String message;
  final String date;
  final String messageType;

  const MessageItem({
    super.key,
    required this.isSender,
    required this.isTail,
    required this.message,
    required this.date,
    required this.messageType,
  });

  @override
  _MessageItemState createState() => _MessageItemState();
}

class _MessageItemState extends State<MessageItem> {
  FlutterSoundPlayer? _player;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _player = FlutterSoundPlayer();
    _player!.openPlayer();
  }

  Future<void> _playPauseAudio() async {
    if (_isPlaying) {
      await _player!.stopPlayer();
      setState(() {
        _isPlaying = false;
      });
    } else {
      await Permission.microphone.request();
      await _player!.startPlayer(
        fromURI: widget
            .message, // Assuming widget.message contains the URL of the voice message
        codec: Codec.aacADTS,
        whenFinished: () {
          setState(() {
            _isPlaying = false;
          });
        },
      );
      setState(() {
        _isPlaying = true;
      });
    }
  }

  void _openPdf(BuildContext context) async {
    if (widget.message.isNotEmpty) {
      final pdfUrl =
          widget.message; // Assuming this is the Firebase Storage URL
      print('Opening PDF from URL: $pdfUrl'); // Debug statement

      // Download the PDF file from Firebase Storage
      try {
        final ref = FirebaseStorage.instance.refFromURL(pdfUrl);
        final tempDir = await getTemporaryDirectory();
        final filePath = '${tempDir.path}/temp.pdf';
        final file = File(filePath);
        await ref.writeToFile(file);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PdfViewScreen(pdfUrl: filePath),
          ),
        );
      } catch (e) {
        print('Error downloading PDF: $e');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error opening PDF')),
        );
      }
    }
  }

  @override
  void dispose() {
    _player!.closePlayer();
    _player = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment:
          widget.isSender ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.messageType == 'voice'
              ? _playPauseAudio
              : (widget.messageType == 'pdf' ? () => _openPdf(context) : null),
          child: BubbleSpecialThree(
            text: widget.messageType == 'voice'
                ? (_isPlaying ? 'Playing...' : 'Tap to play')
                : (widget.messageType == 'pdf'
                    ? 'Tap to open PDF'
                    : widget.message),
            color: widget.isSender ? AppColors.primary : AppColors.third,
            tail: widget.isTail,
            isSender: widget.isSender,
            textStyle: TextStyle(
              color: widget.isSender ? Colors.white : AppColors.primary,
              fontFamily: AppStrings.fontFamily,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: Constants.kPadding + 10),
          child: Text(
            widget.date,
            style: TextStyle(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
              fontFamily: AppStrings.fontFamily,
              fontSize: 7,
            ),
          ),
        ),
      ],
    );
  }
}

class PdfViewScreen extends StatelessWidget {
  final String pdfUrl;

  const PdfViewScreen({Key? key, required this.pdfUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('PDF View'),
      ),
      body: PDFView(
        filePath: pdfUrl,
        enableSwipe: true,
        swipeHorizontal: true,
        autoSpacing: false,
        pageFling: false,
        onRender: (_pages) {
          print('PDF Rendered. Number of pages: $_pages');
        },
        onError: (error) {
          print('PDF View Error: $error');
        },
        onPageError: (page, error) {
          print('Error on page $page: $error');
        },
        onViewCreated: (PDFViewController pdfViewController) {
          print('PDF View created');
        },
        onPageChanged: (int? page, int? total) {
          print('Page changed: $page/$total');
        },
      ),
    );
  }

  Future<String> _downloadPdfFile(String url) async {
    final ref = FirebaseStorage.instance.refFromURL(url);
    final tempDir = await getTemporaryDirectory();
    final filePath = '${tempDir.path}/temp.pdf';
    final file = File(filePath);
    await ref.writeToFile(file);
    return filePath;
  }
}
