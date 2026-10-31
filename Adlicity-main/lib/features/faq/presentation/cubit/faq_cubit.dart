

import'package:adlicity/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:bloc/bloc.dart';
import 'package:chat_bubbles/chat_bubbles.dart';
import 'package:equatable/equatable.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


part 'faq_state.dart';

class FaqCubit extends Cubit<FaqState> {
  FaqCubit() : super(FaqInitialState());

  Future<void> fetchFAQData() async {
    try {
      // Access the Firestore instance
      final firestore = FirebaseFirestore.instance;

      // Fetch data from a collection called 'faq' (adjust the collection name as per your Firebase setup)
      final querySnapshot = await firestore.collection('faqs').get();

      // Process the documents and extract the data
      final faqData = querySnapshot.docs.map((doc) => doc.data()).toList();

      // Emit a new state with the fetched data
      emit(FaqLoaded(faqData));
    } catch (e) {
      // Handle any errors that occur during the fetching process
      emit(FaqError('Failed to fetch FAQ data'));
    }
  }
}
class FaqInitial extends FaqState {}






