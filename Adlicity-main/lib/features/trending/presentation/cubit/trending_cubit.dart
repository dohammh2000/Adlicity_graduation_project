import 'package:adlicity/core/widgets/profile_item.dart';
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

part 'trending_state.dart';

class TrendingCubit extends Cubit<TrendingState> {
  TrendingCubit() : super(TrendingInitial());

  String selectedCategory = 'all';
  List<String> categories = [
    'all',
    'tech',
    'fashion',
    'finance',
    'sports',
    'news'
  ];

  void changeCategory(String category) {
    selectedCategory = category;
    emit(TrendingChangeCategory(selectedCategory));
  }

// Method to retrieve top 20 users sorted by number_of_views in descending order
  Future<List<QueryDocumentSnapshot>> getTopUsers() async {
  emit(TrendingLoading());
  try {
    // Retrieve the documents from the 'users' collection
    QuerySnapshot querySnapshot = await FirebaseFirestore.instance
        .collection('users')
        .orderBy('number_of_views', descending: true)
        .limit(20)
        .get();

    // Extract the documents
    List<QueryDocumentSnapshot> profiles = querySnapshot.docs;
    if (profiles.isNotEmpty) {
      emit(TrendingLoaded(profiles));
      return profiles; // Return the list of profiles
    } else {
      emit(TrendingError('No available users'));
      return []; // Return an empty list if no profiles found
    }
  } catch (e) {
    emit(TrendingError('Failed to retrieve users: $e'));
    print('Failed to retrieve users: $e');
    return []; // Return null or handle the error accordingly
  }
}

}
