part of 'add_campgain_cubit.dart';

abstract class AddCampgainState extends Equatable {
  const AddCampgainState();

  @override
  List<Object?> get props => [];
}

class AddCampgainInitial extends AddCampgainState {}
class AddCampgainUpdateActiveStep extends AddCampgainState {
   final int activeStep;

  AddCampgainUpdateActiveStep(this.activeStep);

  @override
  List<Object> get props => [activeStep];
}


// ignore: must_be_immutable
class AddCampgainChangeCategory extends AddCampgainState {
  String selectedCategory;

  AddCampgainChangeCategory(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];


}
// ignore: must_be_immutable
class AddCampgainChangeAdGoal extends AddCampgainState {
  String selectedAdGoal;

  AddCampgainChangeAdGoal(this.selectedAdGoal);

  @override
  List<Object> get props => [selectedAdGoal];


}
// ignore: must_be_immutable
class AddCampgainChangePublishersChoiceType extends AddCampgainState {
  String type;

  AddCampgainChangePublishersChoiceType(this.type);

  @override
  List<Object> get props => [type];


}

// ignore: must_be_immutable
class AddCampgainUpdateSearch extends AddCampgainState {
  String searchText;

  AddCampgainUpdateSearch(this.searchText);

  @override
  List<Object> get props => [searchText];


}
// ignore: must_be_immutable
class AddCampgainToggleAdType extends AddCampgainState {
  final int index;
  final bool value;

  AddCampgainToggleAdType(this.index, this.value); // Correct order

  @override
  List<Object> get props => [index, value]; // Include index as well in props
}
// ignore: must_be_immutable
class AddCampgainToggleAPlatform extends AddCampgainState {
  final int index;
  final bool value;

  AddCampgainToggleAPlatform(this.index, this.value); // Correct order

  @override
  List<Object> get props => [index, value]; // Include index as well in props
}

class SearchLoading extends AddCampgainState {
  const SearchLoading();
  
  @override
  List<Object> get props => [];
}
class UserDataLoaded extends AddCampgainState {
  final List<Map<String, dynamic>> userDataList;

  UserDataLoaded(this.userDataList);

  @override
  List<Object> get props => [userDataList];
}

class SearchError extends AddCampgainState {
  final String message; // Make it final

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}

class ProfileLoading extends AddCampgainState {
  const ProfileLoading();
  
  @override
  List<Object> get props => [];
}
// class ProfileLoaded extends AddCampgainState {
//   final List<Map<String, dynamic>> userProfileList;

//   ProfileLoaded(this.userProfileList);

//   @override
//   List<Object> get props => [userProfileList];
// }

class ProfileLoaded extends AddCampgainState {
  final Map<String, dynamic>  userprofileList;

  ProfileLoaded(this.userprofileList);

  @override
  List<Object> get props => [userprofileList];
}


class ProfileItemVisibilityUpdated extends AddCampgainState {}

class ProfileError extends AddCampgainState {
  final String message; // Make it final

  const ProfileError(this.message);

  @override
  List<Object> get props => [message];
}

class ImageSelectedState extends AddCampgainState {
  final File? imageFile;

  const ImageSelectedState(this.imageFile);

  @override
  List<Object?> get props => [imageFile];
}

class UserProfilesUpdated extends AddCampgainState {
  final List<Map<String, dynamic>> selectedUserProfiles;

  const UserProfilesUpdated(this.selectedUserProfiles);

  @override
  List<Object> get props => [selectedUserProfiles];
}