import 'package:adlicity/core/utils/constants.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';
import 'package:intl/intl.dart';

part 'add_campgain_state.dart';

class AddCampgainCubit extends Cubit<AddCampgainState> {
  AddCampgainCubit() : super(AddCampgainInitial());
  int activeStep = 0;

  final formKey = GlobalKey<FormState>();
  final resourcesFormKey = GlobalKey<FormState>();
  final goalFormKey = GlobalKey<FormState>();

  void updateActiveStep(int i) {
    activeStep = i;
    emit(AddCampgainUpdateActiveStep(activeStep));
  }

  String selectedCategory = 'all';
  void changeCategory(String category) {
    selectedCategory = category;
    emit(AddCampgainChangeCategory(selectedCategory));
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
    emit(AddCampgainToggleAdType(index, value));
  }

  String adGoal = Constants.adGoals[0];
  void changeAdGoal(String goal) {
    adGoal = goal;
    emit(AddCampgainChangeAdGoal(adGoal));
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
    emit(AddCampgainToggleAPlatform(index, value));
  }

  String publishersChoiceType = Constants.publishersChoiceTypes[0];
  void changePublishersChoiceType(String type) {
    publishersChoiceType = type;
    emit(AddCampgainChangePublishersChoiceType(publishersChoiceType));
  }

  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> selectedUserProfiles = [];

  void selectUserProfile(Map<String, dynamic> userProfile) {
    if (selectedUserProfiles.contains(userProfile)) {
      selectedUserProfiles.remove(userProfile);
    } else {
      selectedUserProfiles.add(userProfile);
    }
    emit(UserProfilesUpdated(selectedUserProfiles));
  }

  List<Map<String, dynamic>> userDataList = [];

  Future<List<Map<String, dynamic>>> fetchInfluencerUserData() async {
    try {
      QuerySnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .where('AccountType', isEqualTo: 'Influencer')
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
        List<Map<String, dynamic>> userDataList =
            await fetchInfluencerUserData();
        filteredList = userDataList
            .where((user) => user['FullName']
                .toString()
                .toLowerCase()
                .startsWith(name.toLowerCase()))
            .toList(); // Convert the Iterable to a List

        emit(UserDataLoaded(
            filteredList)); // Emit update state with filtered user data
      } catch (e) {
        emit(
            SearchError("Failed to search")); // Emit error state if query fails
      }
    } else {
      emit(UserDataLoaded(
          [])); // If the search input is empty, emit an empty list
    }
  }

  CollectionReference campgain =
      FirebaseFirestore.instance.collection('campaigns');
  final title = TextEditingController();
  final description = TextEditingController();
  final start = TextEditingController();
  final end = TextEditingController();
  final deadline = TextEditingController();
  final notes = TextEditingController();
  final link = TextEditingController();
  final budget = TextEditingController();
  final image = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;
  Map<String, String> applicants = {};

//add campaign
  Future<void> addCampaign(File? imageFile) async {
    try {
      //final influencerIds = await fetchInfluencerIds();

      List<String> selectedPublisherIds = [];
      if (publishersChoiceType == 'custom') {
        // Iterate through chosen publishers and extract their IDs
        for (var userData in filteredList) {
          selectedPublisherIds
              .add(userData['id']); // Assuming 'id' is the key for user ID
        }
      }

      String imageUrl = ''; // Variable to store the uploaded image URL

      // Check if an image file has been selected
      if (imageFile != null) {
        // Upload image to Firebase Storage
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('images/${DateTime.now().millisecondsSinceEpoch}');
        UploadTask uploadTask = storageReference.putFile(imageFile);
        await uploadTask.whenComplete(() async {
          imageUrl = await storageReference.getDownloadURL();
        });
      }

      final campaignData = {
        'Title': title.text,
        'Description': description.text,
        'start': start.text,
        'end': end.text,
        'deadline': deadline.text,
        'category': selectedCategory,
        'ad_type': chosenAdTypes,
        'notes': notes.text,
        'link': link.text,
        'image': imageUrl, // Assign the image URL to the 'image' field
        'budget': budget.text,
        'platform': chosenPlatform,
        'publisher': publishersChoiceType,
        'search': searchController.text,
        'creatorId': user!.uid, // Set creatorId to current user's ID
        // 'influencers': publishersChoiceType == 'all' ? influencerIds : [],
        'selectedPublishers':selectedPublisherIds, // Add selected publisher IDs
        'applicants': applicants, // Initialize applicants as an empty array
        'status':'offering',
        'goal':adGoal

      };

      DocumentReference campaignDocRef = await campgain.add(campaignData);
      String campaignId =
          campaignDocRef.id; // Get the ID of the newly added campaign
      print("Campaign Added with ID: $campaignId");

      // Store the campaign ID in the campaign document itself
      await campaignDocRef.update({'campaignId': campaignId});
      print("Campaign ID stored in document");
    } catch (error) {
      print("Failed to add campaign: $error");
    }
  }

//method image
  File? imageFile;

  Future<void> selectImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      imageFile = File(image.path);
      emit(ImageSelectedState(imageFile));
    }
  }

//for start, end and deadline inputfields
  Future<void> selectDate(
      BuildContext context, TextEditingController controller) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null) {
      // controller.text = picked.toString(); // You can format the date as needed
      final formattedDate = DateFormat('yyyy-MM-dd').format(picked);
      controller.text = formattedDate;
    }
  }

  String? validateForm() {
    return validator(
      value: title.text,
      chosenAdTypes: chosenAdTypes,
      chosenPlatform: chosenPlatform,
      adGoal: adGoal,
      selectedCategory: selectedCategory,
      publishersChoiceType: publishersChoiceType,
    );
  }

  String? validateResourcesForm() {
    return validator(
      value: link.text,
      chosenAdTypes: chosenAdTypes,
      chosenPlatform: chosenPlatform,
      adGoal: adGoal,
      selectedCategory: selectedCategory,
      publishersChoiceType: publishersChoiceType,
    );
  }

  String? validateGoalForm() {
    return validator(
      value: budget.text,
      chosenAdTypes: chosenAdTypes,
      chosenPlatform: chosenPlatform,
      adGoal: adGoal,
      selectedCategory: selectedCategory,
      publishersChoiceType: publishersChoiceType,
    );
  }

  String? validator({
    String? value,
    required Map<String, bool> chosenAdTypes,
    required Map<String, bool> chosenPlatform,
    required String adGoal,
    required String selectedCategory,
    required String publishersChoiceType,
  }) {
    if (value == null || value.isEmpty) {
      return 'Field is required';
    }

    bool isAdTypeSelected = chosenAdTypes.containsValue(true);
    if (!isAdTypeSelected) {
      return 'At least one ad type must be selected';
    }

    bool isPlatformSelected = chosenPlatform.containsValue(true);
    if (!isPlatformSelected) {
      return 'At least one platform must be selected';
    }

    if (adGoal.isEmpty) {
      return 'Ad goal is required';
    }

    if (selectedCategory.isEmpty || selectedCategory == 'all') {
      return 'Category selection is required';
    }

    if (publishersChoiceType.isEmpty) {
      return 'Publishers choice type is required';
    }

    return null;
  }
  // Reset form method
  void resetForm() {
    // Clear all text controllers
    title.clear();
    description.clear();
    start.clear();
    end.clear();
    deadline.clear();
    notes.clear();
    link.clear();
    budget.clear();
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