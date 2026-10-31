import 'dart:io';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/input_field.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gap/gap.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../config/themes/app_colors.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import 'main_button.dart';

class FollowersDialog extends StatefulWidget {
  @override
  _FollowersDialogState createState() => _FollowersDialogState();
}

class _FollowersDialogState extends State<FollowersDialog> {
  final CollectionReference followersCollection =
      FirebaseFirestore.instance.collection('users');

  TextEditingController facebookURL = TextEditingController();
  TextEditingController facebookFollowers = TextEditingController();
  TextEditingController instagramURL = TextEditingController();
  TextEditingController instagramFollowers = TextEditingController();
  TextEditingController xURL = TextEditingController();
  TextEditingController xFollowers = TextEditingController();
  TextEditingController youtubeURL = TextEditingController();
  TextEditingController youtubeFollowers = TextEditingController();
  TextEditingController tiktokURL = TextEditingController();
  TextEditingController tiktokFollowers = TextEditingController();
  TextEditingController twitterURL = TextEditingController();
  TextEditingController twitterFollowers = TextEditingController();
  TextEditingController portfolioText = TextEditingController();
  TextEditingController infoText = TextEditingController();

  File? selectedImage;
  String? uploadedImageUrl;

  Future<void> _pickImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? pickedImage =
        await _picker.pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      setState(() {
        selectedImage = File(pickedImage.path);
      });
    }
  }

  Future<void> _fetchImage() async {
    try {
      final String userId = FirebaseAuth.instance.currentUser!.uid;
      final ref = FirebaseStorage.instance.ref().child('userImages/$userId.jpg');
      final url = await ref.getDownloadURL();
      setState(() {
        uploadedImageUrl = url;
      });
    } catch (e) {
      print('Failed to load image: $e');
    }
  }

  Future<void> _launchURL(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    } else {
      throw 'Could not launch $url';
    }
  }


  void _saveData() {
    followersCollection.doc(FirebaseAuth.instance.currentUser!.uid).update({
      'facebookURL': facebookURL.text,
      'facebookFollowers': facebookFollowers.text,
      'instagramURL': instagramURL.text,
      'instagramFollowers': instagramFollowers.text,
      'xURL': xURL.text,
      'xFollowers': xFollowers.text,
      'youtubeURL': youtubeURL.text,
      'youtubeFollowers': youtubeFollowers.text,
      'tiktokURL': tiktokURL.text,
      'tiktokFollowers': tiktokFollowers.text,
      'twitterURL': twitterURL.text,
      'twitterFollowers': twitterFollowers.text,
      'portfolio': portfolioText.text,
      'info': infoText.text,
    }).then((_) {
      print("User added successfully!");
    }).catchError((error) {
      print("Error adding user: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
        ),
        elevation: 0,
        backgroundColor: Colors.transparent,
        child: Container(
          padding: EdgeInsets.all(Constants.kPadding),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Image.asset(
                    IconsAssets.close,
                    width: 12,
                  ),
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.facebook,
                        width: 20,
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: InputField(
                          controller: facebookURL,
                          hintText: 'link'.tr(),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: context.width * 0.25,
                        child: InputField(
                          controller: facebookFollowers,
                          hintText: 'followers'.tr(),
                        ),
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () => _launchURL('https://www.facebook.com/'),
                        child: Text('Go'),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.tiktok,
                        width: 20,
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: InputField(
                          controller: tiktokURL,
                          hintText: 'link'.tr(),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: context.width * 0.25,
                        child: InputField(
                          controller: tiktokFollowers,
                          hintText: 'followers'.tr(),
                        ),
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () => _launchURL('https://www.tiktok.com/en/'),
                        child: Text('Go'),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.instagram,
                        width: 20,
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: InputField(
                          controller: instagramURL,
                          hintText: 'link'.tr(),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: context.width * 0.25,
                        child: InputField(
                          controller: instagramFollowers,
                          hintText: 'followers'.tr(),
                        ),
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () => _launchURL('https://www.instagram.com/'),
                        child: Text('Go'),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.youtube,
                        width: 20,
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: InputField(
                          controller: youtubeURL,
                          hintText: 'link'.tr(),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: context.width * 0.25,
                        child: InputField(
                          controller: youtubeFollowers,
                          hintText: 'followers'.tr(),
                        ),
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () => _launchURL('https://www.youtube.com/'),
                        child: Text('Go'),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Image.asset(
                        IconsAssets.twitter,
                        width: 20,
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: InputField(
                          controller: twitterURL,
                          hintText: 'link'.tr(),
                        ),
                      ),
                      SizedBox(width: 10),
                      SizedBox(
                        width: context.width * 0.25,
                        child: InputField(
                          controller: twitterFollowers,
                          hintText: 'followers'.tr(),
                        ),
                      ),
                      Gap(10),
                      ElevatedButton(
                        onPressed: () => _launchURL('https://x.com/?lang=en'),
                        child: Text('Go'),
                      ),
                    ],
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Portfolio:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.5,
                        child: InputField(
                          controller: portfolioText,
                          hintText: 'Enter your portfolio',
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Text(
                        'Info:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.6,
                        child: InputField(
                          controller: infoText,
                          hintText: 'Enter your info',
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 15),
              Column(
                children: [
                  Row(
                    children: [
                      Gap(10),
                      SizedBox(
                        width: context.width * 0.35,
                        child: TextButton(
                          onPressed: _pickImage,
                          child: Text('Upload Image'),
                        ),
                      ),
                      SizedBox(
                        width: context.width * 0.35,
                        child: TextButton(
                          onPressed: _fetchImage,
                          child: Text('Fetch Image'),
                        ),
                      ),
                    ],
                  ),
                  if (uploadedImageUrl != null)
                    Column(
                      children: [
                        SizedBox(height: 10),
                        Image.network(uploadedImageUrl!),
                      ],
                    ),
                ],
              ),
              SizedBox(height: 15),
              SizedBox(height: 8),
              SizedBox(height: 22),
              MainButton(
                onPressed: () {
                  _saveData();
                  Navigator.pop(context);
                },
                title: 'save'.tr(),
              ),
            ],
          ),
        ),
      ),
    );
  
}

}