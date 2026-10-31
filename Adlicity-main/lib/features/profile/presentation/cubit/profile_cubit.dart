


import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';



part 'profile_state.dart';

// // Define the states for the ProfileCubit
// abstract class ProfileState {}

// class ProfileInitial extends ProfileState {}

// class ProfileLoading extends ProfileState {}

// class ProfileLoaded extends ProfileState {
//   final Map<String, dynamic> profileData;

//   ProfileLoaded(this.profileData);
// }

// class ProfileError extends ProfileState {
//   final String errorMessage;

//   ProfileError(this.errorMessage);
// }

// // Define the events that trigger state changes
// abstract class ProfileEvent {}

// class FetchProfileDataById extends ProfileEvent {
//   final String id;

//   FetchProfileDataById(this.id);
// }

// Implement the ProfileCubit

class ProfileCubit extends Cubit<ProfileState> {
  ProfileCubit() : super(ProfileInitial());

 Future<void> fetchDataById(String documentId) async {
  try {
    emit(ProfileLoading()); // Emit loading state to show a progress indicator in the UI

    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(documentId)
        .get();

    if (snapshot.exists && snapshot.data() != null) {
        final Map<String, dynamic> profileData = snapshot.data() as Map<String, dynamic>;
        emit(ProfileLoaded(profileData)); // Emit the profile data as a state
      } else {
        // If the document does not exist, emit a ProfileError state with a descriptive message
        emit(ProfileError("No profile found with ID $documentId."));
      }
    } catch (e) {
      // On exception, emit an error state with the error message
      emit(ProfileError('Failed to fetch profile data. Error: ${e.toString()}'));
    }
  }


void saveDataToFirestore(Map<String, dynamic> data) async {
    try {
      final DocumentReference documentRef =
          FirebaseFirestore.instance.collection('users').doc();
      await documentRef.set(data);
      // Show success dialog or perform any other desired action
    } catch (e) {
      // Show error dialog or handle the error in an appropriate way
    }
  }



  Future<void> incrementNumberOfViews() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final profileRef = FirebaseFirestore.instance.collection('users').doc(user!.uid);

      await profileRef.update({'number_of_views': FieldValue.increment(1)});
    } catch (e) {
       // On exception, emit an error state with the error message
      emit(ProfileError('Failed to fetch profile data. Error: ${e.toString()}'));
    }
  }

   Future<void> submitReport(String report) async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      final profileRef = FirebaseFirestore.instance.collection('Rates_Report').doc(user!.uid);

      await profileRef.update({
        'report': report,
      });

      emit(ReportSubmitted(true));
    } catch (e) {
      emit(ReportSubmitted(false));
    }
  }

  void loadlastCampaigns() async {
  emit(Loading());
  try {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Fetch campaigns where the user is the creator
      QuerySnapshot creatorQuerySnapshot = await FirebaseFirestore.instance
          .collection('campaigns')
          .where('creatorId', isEqualTo: userId)
          .get();

      if (creatorQuerySnapshot.docs.isNotEmpty) {
        List<DocumentSnapshot> campaigns = creatorQuerySnapshot.docs;
        Map<String, Map<String, dynamic>> campaignsWithApplicants = {};

        for (DocumentSnapshot campaignDoc in campaigns) {
          Map<String, dynamic> campaignData =
              campaignDoc.data() as Map<String, dynamic>;
          String campaignId = campaignDoc.id;

          // Ensure 'applicants' is a Map<String, String>
          Map<String, String> applicants =
              Map<String, String>.from(campaignData['applicants'] ?? {});

          Map<String, dynamic> applicantsData = {};

          for (var entry in applicants.entries) {
            String applicantId = entry.key;
            String status = entry.value;

            if (status == 'pending') {
              DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                  .collection('users')
                  .doc(applicantId)
                  .get();

              if (userSnapshot.exists) {
                Map<String, dynamic> userData =
                    userSnapshot.data() as Map<String, dynamic>;
                applicantsData[applicantId] = userData;
              }
            }
          }

          // Add the length of the applicants map
          int applicantsLength = applicants.length;

          campaignsWithApplicants[campaignId] = {
            'campaignData': campaignData,
            'applicantsData': applicantsData,
            'applicantsLength': applicantsLength,
            'applicantsIds': applicants.keys.toList() // Add the applicants' IDs
          };
        }
        
        emit(CampaignsWithApplicantsLoaded(campaignsWithApplicants));
        print('Campaigns with Applicants Data: $campaignsWithApplicants');
      } else {
        // Fetch all campaigns to check if the user is an applicant
        QuerySnapshot campaignQuerySnapshot = await FirebaseFirestore.instance
            .collection('campaigns')
            .get();
        List<DocumentSnapshot> campaigns = campaignQuerySnapshot.docs;
        Map<String, Map<String, dynamic>> userApplicantCampaignsWithApplicants = {};

        for (DocumentSnapshot campaignDoc in campaigns) {
          Map<String, dynamic> campaignData =
              campaignDoc.data() as Map<String, dynamic>;

          // Ensure 'applicants' is a Map<String, String>
          Map<String, String> applicants =
              Map<String, String>.from(campaignData['applicants'] ?? {});

          if (applicants.containsKey(userId)) {
            Map<String, dynamic> applicantsData = {};

            for (var entry in applicants.entries) {
              String applicantId = entry.key;
              String status = entry.value;

              if (status == 'pending') {
                DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
                    .collection('users')
                    .doc(applicantId)
                    .get();

                if (userSnapshot.exists) {
                  Map<String, dynamic> userData =
                      userSnapshot.data() as Map<String, dynamic>;
                  applicantsData[applicantId] = userData;
                }
              }
            }

            // Add the length of the applicants map
            int applicantsLength = applicants.length;

            userApplicantCampaignsWithApplicants[campaignDoc.id] = {
              'campaignData': campaignData,
              'applicantsData': applicantsData,
              'applicantsLength': applicantsLength,
              'applicantsIds': applicants.keys.toList() // Add the applicants' IDs
            };
          }
        }

        if (userApplicantCampaignsWithApplicants.isNotEmpty) {
          emit(CampaignsWithApplicantsLoaded(userApplicantCampaignsWithApplicants));
        } else {
          emit(CampaignError('No campaigns found for the user'));
        }
      }
    }
  } catch (e) {
    emit(CampaignError('Error fetching campaigns: $e'));
  }
}





  @override
  void onChange(Change<ProfileState> change) {
    print(change);
    super.onChange(change);
  }

  void updateProfileData({required facebookFollowers, required instagramFollowers, required profileInfo, required profileName, required profileRate, required tiktokFollowers, required twitterFollowers, required youTubeFollowers}) {}
}