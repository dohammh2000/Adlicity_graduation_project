import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/features/add_campaign/presentation/cubit/add_campgain_cubit.dart';
import 'package:adlicity/features/add_campaign/presentation/screens/add_campgain_screen.dart';
import 'package:adlicity/features/add_proposal/presentation/cubit/add_proposal_cubit.dart';
import 'package:adlicity/features/add_proposal/presentation/screens/add_proposal_screen.dart';
import 'package:adlicity/features/home/presentation/cubit/home_cubit.dart';
import 'package:adlicity/features/home/presentation/screens/home_screen.dart';
import 'package:adlicity/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:adlicity/features/profile/presentation/screens/profile_screen.dart';
import 'package:adlicity/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:adlicity/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_zoom_drawer/flutter_zoom_drawer.dart';

import '../../../campaigns/presentation/cubit/campaign_cubit.dart';
import '../../../campaigns/presentation/screens/campaigns_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

part 'main_layout_state.dart';
 
class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> getUserAccountType(String userId) async {
    final doc = await _firestore.collection('users').doc(userId).get();
    if (doc.exists) {
      return doc.data()?['AccountType'] ??
          'Advertiser'; // default to 'advertiser'
    } else {
      return 'Advertiser'; // default value if user doc doesn't exist
    }
  }
}

class MainLayoutCubit extends Cubit<MainLayoutState> {
  final FirebaseService firebaseService;

  MainLayoutCubit({required this.firebaseService, required this.user})
      : super(MainLayoutInitial()) {
    _initializeScreens();
  }
  User? user = FirebaseAuth.instance.currentUser;

  int currentScreenIndex = 0;
  final zoomDrawerController = ZoomDrawerController();
  List<String> mainScreensTitles = [];
  List<Widget> mainScreens = [];

  Future<void> _initializeScreens() async {
    try {
      emit(MainLayoutLoading());
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final AccountType = await firebaseService.getUserAccountType(user.uid);
        if (AccountType == 'Advertiser') {
          mainScreens = [
            BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
            BlocProvider(
                create: (context) => CampaignCubit(), child: CampaignsScreen()),
            BlocProvider(
                create: (context) => AddCampgainCubit(),
                child: AddCampgainScreen()),
            BlocProvider(
                create: (context) => WalletCubit(), child: WalletScreen()),
            BlocProvider(
              create: (context) => ProfileCubit(),
              child: ProfileScreen(

              ),
            ),
          ];
          mainScreensTitles = [
            'home',
            'campaigns',
            'new_campaign',
            'wallet',
            'profile'
          ];
        } else if (AccountType == 'Influencer') {
          mainScreens = [
            BlocProvider(create: (context) => HomeCubit(), child: HomeScreen()),
            BlocProvider(
                create: (context) => CampaignCubit(), child: CampaignsScreen()),
            BlocProvider(
                create: (context) => AddProposalCubit(),
                child: AddProposalScreen()),
            BlocProvider(
                create: (context) => WalletCubit(), child: WalletScreen()),
            BlocProvider(
              create: (context) => ProfileCubit(),
              child: ProfileScreen(  ),
            ),
          ];
          mainScreensTitles = [
            'home',
            'campaigns',
            'new_proposal',
            'wallet',
            'profile'
          ];
        }
      }
      emit(MainLayoutLoaded());
    } catch (e) {
      emit(MainLayoutError('Failed to initialize screens: $e'));
    }
  }

  void changeMainScreen(int index) {
    if (index >= 0 && index < mainScreens.length) {
      currentScreenIndex = index;
      emit(MainScreenChanged(currentScreenIndex));
    }
  }


  Future<Map<String, dynamic>?> getUserData(String uid) async {
  try {
    // Reference to the users collection
    CollectionReference users = FirebaseFirestore.instance.collection('users');

    // Get the document by ID
    DocumentSnapshot documentSnapshot = await users.doc(uid).get();

    // Check if the document exists
    if (documentSnapshot.exists) {
      // Get the data from the document
      Map<String, dynamic> data = documentSnapshot.data() as Map<String, dynamic>;
      String fullName = data['FullName'];
      String profileImage = data['profileImage'];

      // Return the required fields in a map
      return {
        'FullName': fullName,
        'profileImage': profileImage,
      };
    } else {
      // Document does not exist
      return null;
    }
  } catch (e) {
    print('Error getting user data: $e');
    return null;
  }
}
}