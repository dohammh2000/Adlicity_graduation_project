part of 'add_proposal_cubit.dart';

abstract class AddProposalState extends Equatable {
  const AddProposalState();

  @override
  List<Object> get props => [];
}

class AddProposalInitial extends AddProposalState {}

class AddProposalUpdateActiveStep extends AddProposalState {
   final int activeStep;

  AddProposalUpdateActiveStep(this.activeStep);

  @override
  List<Object> get props => [activeStep];
}



// ignore: must_be_immutable
class AddProposalChangeCategory extends AddProposalState {
  String selectedCategory;

  AddProposalChangeCategory(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];


}
// ignore: must_be_immutable
class AddProposalChangeAdGoal extends AddProposalState {
  String selectedAdGoal;

  AddProposalChangeAdGoal(this.selectedAdGoal);

  @override
  List<Object> get props => [selectedAdGoal];


}
// ignore: must_be_immutable
class AddProposalChangePublishersChoiceType extends AddProposalState {
  String type;

  AddProposalChangePublishersChoiceType(this.type);

  @override
  List<Object> get props => [type];


}

// ignore: must_be_immutable
class AddProposalUpdateSearch extends AddProposalState {
  String searchText;

  AddProposalUpdateSearch(this.searchText);

  @override
  List<Object> get props => [searchText];


}
// ignore: must_be_immutable
class AddProposalToggleAdType extends AddProposalState {
  final int index;
  final bool value;

  AddProposalToggleAdType(this.index, this.value); // Correct order

  @override
  List<Object> get props => [index, value]; // Include index as well in props
}
// ignore: must_be_immutable
class AddProposalToggleAPlatform extends AddProposalState {
  final int index;
  final bool value;

  AddProposalToggleAPlatform(this.index, this.value); // Correct order

  @override
  List<Object> get props => [index, value]; // Include index as well in props
}

class SearchLoading extends AddProposalState {
  const SearchLoading();
  
  @override
  List<Object> get props => [];
}
class UserDataLoaded extends AddProposalState {
  final List<Map<String, dynamic>> userDataList;

  UserDataLoaded(this.userDataList);

  @override
  List<Object> get props => [userDataList];
}

class SearchError extends AddProposalState {
  final String message; // Make it final

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class UserProfilesUpdated extends AddProposalState {
  final List<Map<String, dynamic>> selectedUserProfiles;

  const UserProfilesUpdated(this.selectedUserProfiles);

  @override
  List<Object> get props => [selectedUserProfiles];
}