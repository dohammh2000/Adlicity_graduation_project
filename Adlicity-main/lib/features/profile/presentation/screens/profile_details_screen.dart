import 'package:adlicity/features/profile/presentation/widgets/profile_body.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/assets_manager.dart';

class ProfileDetailsScreen extends StatefulWidget {
  const ProfileDetailsScreen(
      {super.key,
      required this.profileImage,
      required this.profileInfo,
      required this.tiktokFollowers,
      required this.facebookFollowers,
      required this.twitterFollowers,
      required this.youTubeFollowers,
      required this.instagramFollowers,
      required this.profileName,
      required this.profileRate});

  final String profileImage;
  final String profileInfo;
  final String tiktokFollowers;
  final String facebookFollowers;
  final String twitterFollowers;
  final String youTubeFollowers;
  final String instagramFollowers;
  final String profileName;
  final double profileRate;

  @override
  State<ProfileDetailsScreen> createState() => _ProfileDetailsScreenState();
}

class _ProfileDetailsScreenState extends State<ProfileDetailsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isScrolling = false;

  void initState() {
    super.initState();
    _tabController = TabController(
        length: 3,
        vsync:
            this); // Change the length according to the number of tabs you want

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appbar(context),
      body: ProfileBody(
        isScrolling: _isScrolling,
        scrollController: _scrollController,
        tabController: _tabController,
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
      // title: Text(
      //   'settings'.tr(),
      //   style: TextStyle(fontFamily: AppStrings.fontFamily, fontSize: 20),
      // ),
      // centerTitle: true,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.offset > 0) {
      // User started scrolling
      setState(() {
        _isScrolling = true;
      });
    } else {
      // User stopped scrolling
      setState(() {
        _isScrolling = false;
      });
    }
  }
}
