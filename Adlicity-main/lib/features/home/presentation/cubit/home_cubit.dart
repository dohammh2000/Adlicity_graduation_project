import 'package:adlicity/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../../core/utils/assets_manager.dart';
import '../../../../core/widgets/profile_item.dart';

part 'home_state.dart';


class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  String selectedCategory = 'all';
  String? AccountType = '';
  Map<String, bool> appliedStates = {};

  @override
  void MainLayoutInitial() {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        print('User is currently signed out!');
      } else {
        print('User is signed in!');
      }
    });
  }

  void changeCategory(String category) {
    selectedCategory = category;
    emit(HomeChangeCategory(selectedCategory));
  }

  int currentBannerIndex = 0;
  List banners = [
    ImagesAssets.logo,
    ImagesAssets.logo,
    ImagesAssets.logo,
  ];

  void changeBannerIndex(int index) {
    currentBannerIndex = index;
    emit(HomeChangeBannerIndex(currentBannerIndex));
  }

  Future<String?> getCurrentUserName() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
        String? userName = userSnapshot['FullName'];
        return userName;
      } else {
        return null;
      }
    } catch (e) {
      print('Error fetching current user data: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>> getCampaignsWithCreatorData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      AccountType = userSnapshot['AccountType'];

      if (AccountType == 'Influencer') {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('campaigns')
            .where('publisher', isEqualTo: 'all')
            .get();
        List<DocumentSnapshot> docs = querySnapshot.docs;
        List<Map<String, dynamic>> campaignsWithCreatorData = [];
        for (DocumentSnapshot doc in docs) {
          String creatorId = doc['creatorId'];
          DocumentSnapshot creatorSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(creatorId)
              .get();
          Map<String, dynamic> campaignWithCreatorData = {
            'campaignData': doc.data(),
            'creatorData': creatorSnapshot.data(),
          };
          campaignsWithCreatorData.add(campaignWithCreatorData);
        }
        return campaignsWithCreatorData;
      } else if (AccountType == 'Advertiser') {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('proposals')
            .where('advertiser', isEqualTo: 'all')
            .get();
        List<DocumentSnapshot> docs = querySnapshot.docs;
        List<Map<String, dynamic>> proposalsWithCreatorData = [];
        for (DocumentSnapshot doc in docs) {
          String creatorId = doc['creatorId'];
          DocumentSnapshot creatorSnapshot = await FirebaseFirestore.instance
              .collection('users')
              .doc(creatorId)
              .get();
          Map<String, dynamic> proposalWithCreatorData = {
            'proposalData': doc.data(),
            'creatorData': creatorSnapshot.data(),
          };
          proposalsWithCreatorData.add(proposalWithCreatorData);
        }
        return proposalsWithCreatorData;
      } else {
        print('User is not authenticated.');
        return [];
      }
    } catch (e) {
      print('Error fetching campaign data: $e');
      return [];
    }
  }

  Future<void> loadAppliedStates() async {
    final prefs = await SharedPreferences.getInstance();
    final appliedIds = prefs.getStringList('appliedCampaigns') ?? [];
    appliedStates = {for (var id in appliedIds) id: true};
    emit(HomeStateUpdated());  // Notify listeners
  }

  Future<void> _saveAppliedState(String id, bool applied) async {
    final prefs = await SharedPreferences.getInstance();
    if (applied) {
      appliedStates[id] = true;
    } else {
      appliedStates.remove(id);
    }
    prefs.setStringList('appliedCampaigns', appliedStates.keys.toList());
    emit(HomeStateUpdated());  // Notify listeners 
  }

  Future<void> applyToCampaign(String campaignId) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot campaignSnapshot = await FirebaseFirestore.instance
            .collection('campaigns')
            .doc(campaignId)
            .get();
        if (campaignSnapshot.exists) {
          Map<String, dynamic>? campaignData = campaignSnapshot.data() as Map<String, dynamic>?;
          Map<String, dynamic>? applicants = campaignData?['applicants'] as Map<String, dynamic>?;
          applicants ??= {};
          if (applicants.containsKey(userId)) {
            applicants.remove(userId);
            print('User application removed from campaign');
          } else {
            applicants[userId] = 'pending';
            print('Applied to campaign successfully');
          }
          await FirebaseFirestore.instance
              .collection('campaigns')
              .doc(campaignId)
              .update({'applicants': applicants});
          await _saveAppliedState(campaignId, applicants.containsKey(userId));
        } else {
          print('Campaign not found');
        }
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Failed to apply to campaign: $e');
    }
  }

  Future<void> applyToProposal(String proposalId) async {
      try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        DocumentSnapshot proposalSnapshot = await FirebaseFirestore.instance
            .collection('proposals')
            .doc(proposalId)
            .get();
        if (proposalSnapshot.exists) {
          Map<String, dynamic>? proposalData = proposalSnapshot.data() as Map<String, dynamic>?;
          Map<String, dynamic>? applicants = proposalData?['applicants'] as Map<String, dynamic>?;
          applicants ??= {};
          if (applicants.containsKey(userId)) {
            applicants.remove(userId);
            print('User application removed from proposal');
          } else {
            applicants[userId] = 'pending';
            print('Applied to proposal successfully');
          }
          await FirebaseFirestore.instance
              .collection('proposals')
              .doc(proposalId)
              .update({'applicants': applicants});
          await _saveAppliedState(proposalId, applicants.containsKey(userId));
        } else {
          print('proposal not found');
        }
      } else {
        print('User not authenticated');
      }
    } catch (e) {
      print('Failed to apply to proposal: $e');
    }
  }



      Future<List<QueryDocumentSnapshot>> getTopUsers() async {
  emit(TrendingLoading());
  try {
    // Retrieve the documents from the 'users' collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('number_of_views', descending: true)
        .limit(20)
        .get();

    // Extract the documents
    List<QueryDocumentSnapshot> profiles = querySnapshot.docs;
    if (profiles.isNotEmpty) {
      emit(TrendingLoaded(profiles));
      return profiles; // Return the list of profiles
    } else {
      emit(TrendingError('No available users'));
      return []; // Return an empty list if no profiles found
    }
  } catch (e) {
    emit(TrendingError('Failed to retrieve users: $e'));
    print('Failed to retrieve users: $e');
    return []; // Return null or handle the error accordingly
  }
}
}

