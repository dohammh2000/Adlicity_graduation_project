import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Constants {
  static void showErrorDialog(
      {required BuildContext context, required String msg}) {
    showDialog(
        context: context,
        builder: (context) => CupertinoAlertDialog(
              title: Text(
                msg,
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.black,
                      textStyle: const TextStyle(
                          fontSize: 14, fontWeight: FontWeight.bold)),
                  child: const Text('Ok'),
                )
              ],
            ));
  }

  static double kPadding = 20;
  static double kRoundedCorner = 8;

  static List<String> testUsersImages = [
    ImagesAssets.preson1,
    ImagesAssets.preson2,
    ImagesAssets.preson3,
    ImagesAssets.preson4,
    ImagesAssets.preson1,
    ImagesAssets.preson2,
    ImagesAssets.preson3,
    ImagesAssets.preson4,
    ImagesAssets.preson1,
    ImagesAssets.preson2,
    ImagesAssets.preson3,
    ImagesAssets.preson4,
  ];

  static List<Map<String, dynamic>> proposalsTest = [
    {
      'facebookFollowers': '2.5M',
      'instagramFollowers': '293.8K',
      'tiktokFollowers': '139K',
      'twitterFollowers': '32K',
      'youTubeFollowers': '2K',
      'profileImage': ImagesAssets.preson1,
      'profileInfo': 'Tech Influncer',
      'profileName': 'Sherif Mahmoud',
      'profileRate': 4.6,
      'category': 'fashion',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'title': 'Title',
      'price': '150',
    },
    {
      'facebookFollowers': '2.5M',
      'instagramFollowers': '293.8K',
      'tiktokFollowers': '139K',
      'twitterFollowers': '32K',
      'youTubeFollowers': '2K',
      'profileImage': ImagesAssets.preson2,
      'profileInfo': 'Tech Influncer',
      'profileName': 'Sherif Mahmoud',
      'profileRate': 4.6,
      'category': 'fashion',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'title': 'Title',
      'price': '150',
    },
    {
      'facebookFollowers': '2.5M',
      'instagramFollowers': '293.8K',
      'tiktokFollowers': '139K',
      'twitterFollowers': '32K',
      'youTubeFollowers': '2K',
      'profileImage': ImagesAssets.preson3,
      'profileInfo': 'Tech Influncer',
      'profileName': 'Sherif Mahmoud',
      'profileRate': 4.6,
      'category': 'fashion',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'title': 'Title',
      'price': '150',
    },
    {
      'facebookFollowers': '2.5M',
      'instagramFollowers': '293.8K',
      'tiktokFollowers': '139K',
      'twitterFollowers': '32K',
      'youTubeFollowers': '2K',
      'profileImage': ImagesAssets.preson4,
      'profileInfo': 'Tech Influncer',
      'profileName': 'Sherif Mahmoud',
      'profileRate': 4.6,
      'category': 'fashion',
      'description':
          'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry’s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.',
      'title': 'Title',
      'price': '150',
    },
  ];

  static List<String> categories = [
    'all',
    'tech',
    'fashion',
    'finance',
    'sports',
    'news'
  ];

  static List<String> adTypes = [
    'fullVideo',
    'reel',
    'story',
    'inVideo',
    'post',
  ];
  static List<String> adGoals = [
    'increase_sales',
    'engagements',
    'leads',
    'installs',
    'brand_awareness',
    'boost_social_media',
    'traffic',
  ];
  static List<String> platforms = [ 
    'instagram',
    'tiktok',
    'youtube',
    'facebook',
    'x',
  ];
  static List<String> publishersChoiceTypes = [
    'all',
    // 'system_recommendtion',
    'custom',
  ];

  static List<String> usersImagesTest = [
    ImagesAssets.preson1,
    ImagesAssets.preson2,
    ImagesAssets.preson3,
    ImagesAssets.preson4,
    ImagesAssets.preson1,
    ImagesAssets.preson2,
    ImagesAssets.preson3,
    ImagesAssets.preson4,
  ];
}
