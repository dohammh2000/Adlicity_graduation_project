import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

part 'search_state.dart';



//         class SearchCubit extends Cubit<SearchState> {
//         SearchCubit() : super(SearchInitial());

//         TextEditingController searchController = TextEditingController();
//         String name='';

//         Future<List<Map<String, dynamic>>> fetchUserData() async {
//         try {
//         QuerySnapshot snapshot =
//         await FirebaseFirestore.instance.collection('users').get();
//         List<Map<String, dynamic>> userDataList = snapshot.docs
//         .map((doc) => doc.data() as Map<String, dynamic>)
//         .toList();
//         return userDataList;
//         } catch (error) {
//         throw error.toString();
//         }
//         }

//       void updateSearch(String name) async {
//   if (name.isNotEmpty) {
//     emit(SearchLoading()); // Emit loading state
//     try {
//       List<Map<String, dynamic>> userDataList = await fetchUserData();
//       List<Map<String, dynamic>> filteredList = userDataList
//           .where((user) => user['FullName']
//               .toString()
//               .toLowerCase()
//               .startsWith(name.toLowerCase()))
//           .toList(); // Convert the Iterable to a List

//       emit(UserDataLoaded(filteredList)); // Emit update state with filtered user data
//     } catch (e) {
//       emit(SearchError("Failed to search")); // Emit error state if query fails
//     }
//   } else {
//     emit(UserDataLoaded([])); // If the search input is empty, emit an empty list
//   }
// }


//         String selectedCategory = 'all';
//         void changeCategory(String category) {
//         selectedCategory = category;
//         emit(SearchSChangeCategory(selectedCategory));
//         }
//         }

class SearchCubit extends Cubit<SearchState> {
  SearchCubit() : super(SearchInitial());

  TextEditingController searchController = TextEditingController();
  String name = '';
  String selectedCategory = 'all';

  Future<List<Map<String, dynamic>>> fetchUserData() async {
    try {
      QuerySnapshot snapshot =
          await FirebaseFirestore.instance.collection('users').get();
      List<Map<String, dynamic>> userDataList = snapshot.docs
          .map((doc) => doc.data() as Map<String, dynamic>)
          .toList();
      return userDataList;
    } catch (error) {
      throw error.toString();
    }
  }

  void updateSearch(String name, String category) async {
    if (name.isNotEmpty || category != 'all') {
      emit(SearchLoading()); // Emit loading state
      try {
        List<Map<String, dynamic>> userDataList = await fetchUserData();
        List<Map<String, dynamic>> filteredList = userDataList
            .where((user) {
              bool matchesName = user['FullName']
                  .toString()
                  .toLowerCase()
                  .startsWith(name.toLowerCase());
              bool matchesCategory = 
                  user['category']
                      .toString()
                      .toLowerCase() == category.toLowerCase();
              return matchesName && matchesCategory;
            })
            .toList(); // Convert the Iterable to a List

        emit(UserDataLoaded(filteredList)); // Emit update state with filtered user data
      } catch (e) {
        emit(SearchError("Failed to search")); // Emit error state if query fails
      }
    } else {
      emit(UserDataLoaded([])); // If the search input is empty, emit an empty list
    }
  }

  void changeCategory(String category) {
    selectedCategory = category;
    updateSearch(name, selectedCategory); // Update search with the new category
    emit(SearchSChangeCategory(selectedCategory));
  }
}