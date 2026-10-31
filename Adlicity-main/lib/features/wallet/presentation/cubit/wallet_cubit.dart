
import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'wallet_state.dart';

class WalletCubit extends Cubit<WalletState> {
  WalletCubit() : super(WalletInitial());
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? depositPaymentMethod;
  String? withdrawPaymentMethod;
  TextEditingController depositAmountController = TextEditingController();
  TextEditingController withdrawAmountController = TextEditingController();
  void loadWalletAmount() async {
    emit(WalletLoading()); // Emit loading state
    try {
      String userId = _auth.currentUser!.uid;
      DocumentSnapshot userDoc =
          await _firestore.collection('users').doc(userId).get();
      double walletAmount = userDoc['walletAmount'].toDouble();
      QuerySnapshot transactionSnapshot = await _firestore
          .collection('users')
          .doc(userId) 
          .collection('transactions')
          .orderBy('date', descending: true)
          .get();
      List<Map<String, dynamic>> transactions =
          transactionSnapshot.docs.map((doc) {
        return {
          'title': doc['title'],
          'amount': doc['amount'],
          'date': doc['date'],
          'subtitle': doc['subtitle'], // Make sure this is treated as a String
          'id': doc['id'],
        };
      }).toList();
      emit(
          WalletLoaded(walletAmount: walletAmount, transactions: transactions));
    } catch (e) {
      emit(WalletError(e.toString()));
    }
  }

  void deposit() async {
    try {
      double depositAmount = double.parse(depositAmountController.text);
      if (depositAmount <= 0 || depositPaymentMethod == null) {
        emit(WalletError("Invalid deposit amount or payment method."));
        return;
      }
      String userId = _auth.currentUser!.uid;
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);

      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot userDoc = await transaction.get(userDocRef);
        double currentWalletAmount = userDoc['walletAmount'].toDouble();
        double newWalletAmount = currentWalletAmount + depositAmount;
        transaction.update(userDocRef, {'walletAmount': newWalletAmount});
        DocumentReference transactionRef =
            userDocRef.collection('transactions').doc();
        transaction.set(transactionRef, {
          'title': 'Deposit',
          'amount': depositAmount,
          'date': Timestamp.now(),
          'subtitle': depositPaymentMethod,
          'id': transactionRef.id,  });  });
      loadWalletAmount(); } catch (e) {
      emit(WalletError(e.toString()));} }
  void withdraw(double amount) async {  try {
      double withdrawAmount = double.parse(withdrawAmountController.text);
      if (withdrawAmount <= 0 || withdrawPaymentMethod == null) {
        emit(WalletError("Invalid withdraw amount or payment method.")); return; }
      String userId = _auth.currentUser!.uid;
      DocumentReference userDocRef = _firestore.collection('users').doc(userId);
      await _firestore.runTransaction((transaction) async {
        DocumentSnapshot userDoc = await transaction.get(userDocRef);
        double currentWalletAmount = userDoc['walletAmount'].toDouble();
        if (withdrawAmount > currentWalletAmount) {
          emit(WalletError("Insufficient funds."));  return;  }
        double newWalletAmount = currentWalletAmount - withdrawAmount;
        transaction.update(userDocRef, {'walletAmount': newWalletAmount});
        DocumentReference transactionRef =
            userDocRef.collection('transactions').doc();
        transaction.set(transactionRef, {
          'title': 'Withdraw',
          'amount': withdrawAmount,
          'date': Timestamp.now(),
          'subtitle': withdrawPaymentMethod,
          'id': transactionRef.id, }); });  loadWalletAmount(); } catch (e) {
      emit(WalletError(e.toString()));}}
  @override
  Future<void> close() {
    depositAmountController.dispose();
    withdrawAmountController.dispose();
    return super.close();}}
