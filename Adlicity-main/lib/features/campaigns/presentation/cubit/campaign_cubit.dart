import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'campaign_state.dart';

class CampaignCubit extends Cubit<CampaignState> {
  CampaignCubit() : super(CampaignInitial());
  //CampaignCubit() : super(Loading());

  bool profileButtonsShown = true;
   Map<String, bool> appliedStates = {};

  void toggleProfileButtonsShown(bool value) {
    profileButtonsShown = value;
    emit(CampaignToggleProfileButtonsShown(profileButtonsShown));
  }



void loadCampaigns() async {
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

void loadCampaignsWithApplicants() async {
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
        // Load campaigns for publishers
        QuerySnapshot dataQuerySnapshot = await FirebaseFirestore.instance
            .collection('campaigns')
            .where('publisher', isEqualTo: 'custom')
            .where('selectedPublishers', arrayContains: userId)
            .get();
        List<DocumentSnapshot> campaigns = dataQuerySnapshot.docs;
        emit(CampaignLoaded(campaigns));
      }
    } else {
      emit(CampaignError('No user logged in'));
    }
  } catch (e) {
    emit(CampaignError('Error fetching campaigns: $e'));
  }
}


  Future<void> acceptApplicant(String campaignId, String applicantId) async {
    try {
      // Update the campaign document to change the status of the applicant to 'accept'
      await FirebaseFirestore.instance
          .collection('campaigns')
          .doc(campaignId)
          .update({
        'applicants.$applicantId': 'accept',
      });
      print('Applicant accepted successfully');
      // Optionally, emit a state indicating that the applicant was accepted
      // You might want to refresh the UI to reflect the updated status
    } catch (e) {
      print('Failed to accept applicant: $e');
      // Optionally, emit a state indicating that the acceptance failed
    }
  }

  Future<void> rejectApplicant(String campaignId, String applicantId) async {
    try {
      // Remove the applicant from the campaign document
      await FirebaseFirestore.instance
          .collection('campaigns')
          .doc(campaignId)
          .update({
        'applicants.$applicantId': FieldValue.delete(),
      });
      print('Applicant rejected successfully');
      // Optionally, emit a state indicating that the applicant was rejected
      // You might want to refresh the UI to reflect the updated status
    } catch (e) {
      print('Failed to reject applicant: $e');
      // Optionally, emit a state indicating that the rejection failed
    }
  }

  Future<void> applyToCampaign(String campaignId) async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId != null) {
        // Update the campaign document to add the user ID to the applicantsStatus map
        await FirebaseFirestore.instance
            .collection('campaigns')
            .doc(campaignId)
            .update({
          'applicants.$userId': 'pending', // Set initial status to 'pending'
        });
        print('Applied to campaign successfully');
        // Optionally, emit a state indicating that the application was successful
      } else {
        print('User not authenticated');
        // Optionally, emit a state indicating that the user is not authenticated
      }
    } catch (e) {
      print('Failed to apply to campaign: $e');
      // Optionally, emit a state indicating that the application failed
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

  Future<void> rejectproposal(String proposalId, List<String>? applicantId) async {
    try {
      // Remove the applicant from the campaign document
      await FirebaseFirestore.instance
          .collection('campaigns')
          .doc(proposalId)
          .update({
        'applicants.$applicantId': FieldValue.delete(),
      });
      print('proposal rejected successfully');
      // Optionally, emit a state indicating that the applicant was rejected
      // You might want to refresh the UI to reflect the updated status
    } catch (e) {
      print('Failed to reject proposal: $e');
      // Optionally, emit a state indicating that the rejection failed
    }
  }

  Future<void> applyToProposalsection(String proposalId) async {
  try {
    String? userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId != null) {
      // Update the campaign document to add the user ID to the applicantsStatus map
      await FirebaseFirestore.instance
          .collection('proposals')
          .doc(proposalId) 
          .update({
        'applicants.$userId': 'pending', // Set initial status to 'pending'
      });
      print('Applied to proposal successfully');
      // Optionally, emit a state indicating that the application was successful
    } else {
      print('User not authenticated');
      // Optionally, emit a state indicating that the user is not authenticated
    }
  } catch (e) {
    print('Failed to apply to propsal: $e');
    // Optionally, emit a state indicating that the application failed
  }
}
  



  String AccountType = '';
 Future<void> getProposalsWithCreatorData() async {
    try {
      String? userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('User not authenticated');
      }

      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      String accountType = userSnapshot['AccountType'];

      List<Map<String, dynamic>> proposalsWithCreatorData = [];

      if (accountType == 'Influencer') {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('proposals')
            .where('creatorId', isEqualTo: userId)
            .get();

        for (DocumentSnapshot doc in querySnapshot.docs) {
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
      } else if (accountType == 'Advertiser') {
        QuerySnapshot querySnapshot = await FirebaseFirestore.instance
            .collection('proposals')
            .where('advertiser', isEqualTo: 'custom')
            .where('selectedPublishers', arrayContains: userId)
            .get();

        for (DocumentSnapshot doc in querySnapshot.docs) {
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
      } else {
        throw Exception('Unknown account type');
      }

      emit(ProposalLoaded(proposalsWithCreatorData));
    } catch (e) {
      emit(CampaignError(e.toString()));
    }
  }
}
