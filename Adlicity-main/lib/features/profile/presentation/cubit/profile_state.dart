part of 'profile_cubit.dart';

abstract class ProfileState extends Equatable  {
  const ProfileState();

  @override
  List<Object> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Map<String, dynamic> profileData;

  const ProfileLoaded(this.profileData);

  @override
  List<Object> get props => [profileData];
}

class ProfileError extends ProfileState {
  final String errorMessage;

  const ProfileError(this.errorMessage);

  @override
  List<Object> get props => [errorMessage];
}

class ReportSubmitted extends ProfileState {
  final bool success;

  const ReportSubmitted(this.success);

  @override
  List<Object> get props => [success];
}

class CampaignsWithApplicantsLoaded extends ProfileState {
  final Map<String, Map<String, dynamic>> campaignsWithApplicants;

  CampaignsWithApplicantsLoaded(this.campaignsWithApplicants);
}

class CampaignError extends ProfileState {
  final String message;
  CampaignError(this.message);
}
class Loading extends ProfileState {}