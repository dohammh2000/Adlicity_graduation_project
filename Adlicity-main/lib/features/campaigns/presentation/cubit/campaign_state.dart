part of 'campaign_cubit.dart';

abstract class CampaignState extends Equatable {
  const CampaignState();

  @override
  List<Object> get props => [];
}

class CampaignInitial extends CampaignState {}

// ignore: must_be_immutable
class CampaignToggleProfileButtonsShown extends CampaignState {
  final bool profileButtonsShown;

  CampaignToggleProfileButtonsShown(this.profileButtonsShown); // Correct order

  @override
  List<Object> get props =>
      [profileButtonsShown]; // Include index as well in props
}

class Loading extends CampaignState {}

class CampaignLoaded extends CampaignState {
  final List<DocumentSnapshot> campaigns;
  CampaignLoaded(this.campaigns);
}

class ProposalLoaded extends CampaignState {
  final List<Map<String, dynamic>> proposals;

  ProposalLoaded(this.proposals);
}

class CampaignError extends CampaignState {
  final String message;
  CampaignError(this.message);
}

class proposalError extends CampaignState {
  final String message;
  proposalError(this.message);
}

class ApplicantsLoaded extends CampaignState {
  final List<DocumentSnapshot> applicants;
  const ApplicantsLoaded(this.applicants);
}

class CampaignApplicantsLoaded extends CampaignState {
  final Map<String, Map<String, dynamic>> applicantsData;

  CampaignApplicantsLoaded(this.applicantsData);

  @override
  List<Object> get props => [applicantsData];
}

// Event classes for states
class CampaignsWithApplicantsLoaded extends CampaignState {
  final Map<String, Map<String, dynamic>> campaignsWithApplicants;

  CampaignsWithApplicantsLoaded(this.campaignsWithApplicants);
}

class HomeStateUpdated extends CampaignState {}
