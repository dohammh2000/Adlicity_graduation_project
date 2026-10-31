
part of 'faq_cubit.dart';

// class FrequentlyAskedQuestion {
//    final String question;
//   final String answer;

//   FrequentlyAskedQuestion({
//     required this.question,
//     required this.answer,
//   });

//   factory FrequentlyAskedQuestion.fromFAQ(FAQ faq) {
//     return FrequentlyAskedQuestion(
//       question: faq.question,
//       answer: faq.answer,
//     );
//   }

//   static fromMap(Map<String, dynamic> data) {}
// }

// class FAQ {
//   final String question;
//   final String answer;

//   FAQ({required this.question, required this.answer});

//   factory FAQ.fromDocument(DocumentSnapshot doc) {
//     final data = doc.data() as Map<String, dynamic>;
//     return FAQ(
//       question: data['question'],
//       answer: data['answer'],
//     );
//   }
// }



abstract class FaqState extends Equatable {
  const FaqState();

  @override
  List<Object> get props => [];
}
class FaqInitialState extends FaqState {}

class FaqLoading extends FaqState {}

class FaqLoaded extends FaqState {
  final List<Map<String, dynamic>> faqData;

  FaqLoaded(this.faqData);

  @override
  List<Object> get props => [faqData];

}

class FaqError extends FaqState {
  final String message;

  const FaqError(this.message);

  @override
  List<Object> get props => [message];
}


