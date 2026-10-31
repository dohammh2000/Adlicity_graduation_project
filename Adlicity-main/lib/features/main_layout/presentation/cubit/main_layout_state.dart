part of 'main_layout_cubit.dart';

abstract class MainLayoutState extends Equatable {
  const MainLayoutState();

  @override
  List<Object> get props => [];
}

class MainLayoutInitial extends MainLayoutState {}

class MainLayoutLoading extends MainLayoutState {}

class MainLayoutLoaded extends MainLayoutState {}

class MainLayoutError extends MainLayoutState {
  final String message;

  MainLayoutError(this.message);

  @override
  List<Object> get props => [message];
}

class MainLayoutUpdatedProfileScreen extends MainLayoutState {}

class MainScreenChanged extends MainLayoutState {
  final int newIndex;

  MainScreenChanged(this.newIndex);

  @override
  List<Object> get props => [newIndex];
}