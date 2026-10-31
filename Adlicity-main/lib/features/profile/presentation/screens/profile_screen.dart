

import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:adlicity/core/widgets/profile_item.dart';
import 'package:adlicity/features/profile/presentation/widgets/profile_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../config/themes/app_colors.dart';
import '../../../../core/utils/app_strings.dart';
import '../../../../core/widgets/followers_dailog.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/profile_info_section.dart';
import '../widgets/profile_portfolio_section.dart';
import '../widgets/profile_statistics_section.dart';
import 'package:url_launcher/url_launcher.dart';



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,

  }) : super(key: key);



  @override
 State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  late ScrollController _scrollController;
  bool _isScrolling = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
 // Increment the number of views when the profile screen is opened
    context.read<ProfileCubit>().incrementNumberOfViews();
  }
 void _showFollowersDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return FollowersDialog();
    },
  );
}

  @override
  Widget build(BuildContext context) {
  
 // Invoke the method here

    return Scaffold(
      body: ProfileBody(
        isScrolling: _isScrolling,
        scrollController: _scrollController,
        tabController: _tabController,
 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _showFollowersDialog(context);
        },
        child: Icon(Icons.edit),
      ),
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
      setState(() {
        _isScrolling = true;
      });
    } else {
      setState(() {
        _isScrolling = false;
      });
    }
  }
}