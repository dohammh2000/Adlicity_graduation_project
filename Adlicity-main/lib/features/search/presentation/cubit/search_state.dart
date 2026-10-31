

part of 'search_cubit.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}
class SearchLoading extends SearchState {
  const SearchLoading();
  
  @override
  List<Object> get props => [];
}
class UserDataLoaded extends SearchState {
  final List<Map<String, dynamic>> userDataList;

  UserDataLoaded(this.userDataList);

  @override
  List<Object> get props => [userDataList];
}

class SearchError extends SearchState {
  final String message; // Make it final

  const SearchError(this.message);

  @override
  List<Object> get props => [message];
}
class UserDataLoadFailed extends SearchState {
  final String message; // Make it final

  const UserDataLoadFailed(this.message);

  @override
  List<Object> get props => [message];
}
class SearchInitial extends SearchState {
  
}

// ignore: must_be_immutable
// class SearchUpdate extends SearchState {
//   String searchText;

//   SearchUpdate(this.searchText);

//   @override
//   List<Object> get props => [searchText];
// }
class SearchUpdate extends SearchState {
  final List<String> searchResults;

  SearchUpdate(this.searchResults);

  @override
  List<Object> get props => [searchResults];
}



// ignore: must_be_immutable
class SearchSChangeCategory extends SearchState {
   final String selectedCategory;

  SearchSChangeCategory(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];

}