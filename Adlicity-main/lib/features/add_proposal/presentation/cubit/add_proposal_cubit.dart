import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../../core/utils/constants.dart';

part 'add_proposal_state.dart';

class AddProposalCubit extends Cubit<AddProposalState> {
  AddProposalCubit() : super(AddProposalInitial());

  int activeStep = 0;

  void updateActiveStep(int i) {
    activeStep = i;
    emit(AddProposalUpdateActiveStep(activeStep));
  }

  String selectedCategory = 'all';
  void changeCategory(String category) {
    selectedCategory = category;
    emit(AddProposalChangeCategory(selectedCategory));
  }

  Map<String, bool> chosenAdTypes = {
    Constants.adTypes[0]: false,
    Constants.adTypes[1]: false,
    Constants.adTypes[2]: false,
    Constants.adTypes[3]: false,
    Constants.adTypes[4]: false,
  };

  void toggleAdType({required int index, required bool value}) {
    chosenAdTypes[Constants.adTypes[index]] = value;
    emit(AddProposalToggleAdType(index, value));
  }

  String adGoal = Constants.adGoals[0];
  void changeAdGoal(String goal) {
    adGoal = goal;
    emit(AddProposalChangeAdGoal(adGoal));
  }

  Map<String, bool> chosenPlatform = {
    Constants.platforms[0]: false,
    Constants.platforms[1]: false,
    Constants.platforms[2]: false,
    Constants.platforms[3]: false,
    Constants.platforms[4]: false,
  };

  void togglePlatform({required int index, required bool value}) {
    chosenPlatform[Constants.platforms[index]] = value;
    emit(AddProposalToggleAPlatform(index, value));
  }

  String publishersChoiceType = Constants.publishersChoiceTypes[0];
  void changePublishersChoiceType(String type) {
    publishersChoiceType = type;
    emit(AddProposalChangePublishersChoiceType(publishersChoiceType));
  }


   List<Map<String, dynamic>> selectedUserProfiles = [];

  void selectUserProfile(Map<String, dynamic> userProfile) {
    if (selectedUserProfiles.contains(userProfile)) {
      selectedUserProfiles.remove(userProfile);
    } else {
      selectedUserProfiles.add(userProfile);
    }
    emit(UserProfilesUpdated(selectedUserProfiles));
  }
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> userDataList = [];


Future<List<Map<String, dynamic>>> fetchAdvertiserUserData() async {
  try {
    QuerySnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .where('AccountType', isEqualTo: 'Advertiser')
        .get();

    userDataList = snapshot.docs
        .map((doc) => doc.data() as Map<String, dynamic>)
        .toList();

    return userDataList;
  } catch (error) {
    throw error.toString();
  }
}

List<Map<String, dynamic>> filteredList = [];
   String name = '';

  void updateSearch(String name) async {
  if (name.isNotEmpty) {
    emit(SearchLoading()); // Emit loading state
    try {
      List<Map<String, dynamic>> userDataList = await fetchAdvertiserUserData();
       filteredList = userDataList
          .where((user) => user['FullName']
              .toString()
              .toLowerCase()
              .startsWith(name.toLowerCase()))
          .toList(); // Convert the Iterable to a List

      emit(UserDataLoaded(filteredList)); // Emit update state with filtered user data
    } catch (e) {
      emit(SearchError("Failed to search")); // Emit error state if query fails
    }
  } else {
    emit(UserDataLoaded([])); // If the search input is empty, emit an empty list
  }
}

  CollectionReference proposal =
      FirebaseFirestore.instance.collection('proposals');
  final title = TextEditingController();
  final description = TextEditingController();
  final duration = TextEditingController();
  final notes = TextEditingController();
  final link = TextEditingController();
  final price = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, String> applicants = {};

   Future<void> addProposal() async {
    try {
      List<String> selectedPublisherIds = [];
      if (publishersChoiceType == 'custom') {
        // Iterate through chosen publishers and extract their IDs
        for (var userData in filteredList) {
          selectedPublisherIds.add(userData['id']); // Assuming 'id' is the key for user ID
        }
      }


      final proposalData = {
        'Title': title.text,
        'Description': description.text,
        'duration': duration.text,
        'category': selectedCategory,
        'ad_type': chosenAdTypes,
        'notes': notes.text,
        'link': link.text,
        'price': price.text,
        'platform': chosenPlatform,
        'advertiser': publishersChoiceType,
        'search': searchController.text,
        'creatorId': user!.uid, // Set creatorId to current user's ID
        'selectedPublishers': selectedPublisherIds, // Add selected publisher IDs
        'applicants': applicants, // Initialize applicants as an empty array
      };

      DocumentReference proposalDocRef = await proposal.add(proposalData);
      String proposalId =proposalDocRef.id; // Get the ID of the newly added campaign
      print("Campaign Added with ID: $proposalId");

      // Store the campaign ID in the campaign document itself
      await proposalDocRef.update({'proposalId': proposalId});
      print("Proposal ID stored in document");
    } catch (error) {
      print("Failed to add propsal: $error");
    }
  }

    String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return ' required';
    }
    return null;
  }

  // Reset form method
  void resetForm() {
    // Clear all text controllers
    title.clear();
    description.clear();
    duration.clear();
    notes.clear();
    link.clear();
    price.clear();
    searchController.clear();

    // Reset state variables
    selectedCategory = 'all';
    chosenAdTypes = {
      Constants.adTypes[0]: false,
      Constants.adTypes[1]: false,
      Constants.adTypes[2]: false,
      Constants.adTypes[3]: false,
      Constants.adTypes[4]: false,
    };
    adGoal = Constants.adGoals[0];
    chosenPlatform = {
      Constants.platforms[0]: false,
      Constants.platforms[1]: false,
      Constants.platforms[2]: false,
      Constants.platforms[3]: false,
      Constants.platforms[4]: false,
    };
    publishersChoiceType = Constants.publishersChoiceTypes[0];
    selectedUserProfiles.clear();
    filteredList.clear();
    name = '';

    // Reset the active step to 0
    updateActiveStep(0);
  }
}
