part of 'home_cubit.dart';

abstract class HomeState extends Equatable {
  const HomeState();

  @override
  List<Object> get props => [];
}

class HomeInitial extends HomeState {}

// ignore: must_be_immutable
class HomeChangeCategory extends HomeState {
  String selectedCategory;

  HomeChangeCategory(this.selectedCategory);

  @override
  List<Object> get props => [selectedCategory];
}

// ignore: must_be_immutable
class HomeChangeBannerIndex extends HomeState {
  int index;

  HomeChangeBannerIndex(this.index);

  @override
  List<Object> get props => [index];
}

class HomeStateUpdated extends HomeState {}


class TrendingLoading extends HomeState {}

class TrendingLoaded extends HomeState {
  final  List<QueryDocumentSnapshot> profiles;
  TrendingLoaded(this.profiles);
}

class TrendingError extends HomeState {
  final String message;
  TrendingError(this.message);
}