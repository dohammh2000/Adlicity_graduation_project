import 'package:adlicity/config/routes/app_routes.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/features/login/presentation/cubit/login_cubit.dart';
import 'package:bloc/bloc.dart';
import 'package:cherry_toast/cherry_toast.dart';
import 'package:cherry_toast/resources/arrays.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

part 'sign_up_state.dart';

class FirebaseAuthService {
  final FirebaseAuth _firebaseAuth;

  FirebaseAuthService(this._firebaseAuth);

  Future<void> signUpWithEmailAndPassword(
      BuildContext context, String email, String password) async {
    try {
      final credential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      // Send email verification
      await credential.user!.sendEmailVerification();

      Navigator.of(context).pushReplacementNamed(Routes.loginRoute);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        // Handle weak password error here
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        // Handle existing account error here
      } else {
        print('Sign up failed: ${e.message}');
        // Handle other FirebaseAuthException errors here
      }
    } catch (e) {
      print('Sign up failed: $e');
      // Handle other exceptions here
    }
  }
}

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final signUpFormKey = GlobalKey<FormState>();
  bool showPassword = false;
  TextEditingController fullNameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController dateOfBirthController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  String accountType = 'Influencer';

  void changeAccountType(String type) {
    accountType = type;
    emit(SignUpChangeAccountType(accountType: accountType));
  }

  void toggleShowPassword(value) {
    showPassword = value;
    emit(SignUpToggleShowPassword(showPassword));
  }

  signUp(context) async {
    var formdata = signUpFormKey.currentState;
    if (formdata!.validate()) {
      formdata.save();
      try {
        // showLoading(context);
        final userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: emailController.text, password: passwordController.text);

        // CollectionReference users =
        //     FirebaseFirestore.instance.collection('users');

        // Future<void> signUp() {
        //   // Call the user's CollectionReference to add a new user
        //   return users
        //       .add({
        //         'FullName': fullNameController.text,
        //         'UserName': usernameController.text,
        //         'Email': emailController.text,
        //         'Password': passwordController.text,
        //         'DateOfBirth': dateOfBirthController.text,
        //         'phoneNumber': phoneNumberController.text,
        //         'profileImage': '', // Add the profile image URL here
        //         'profileInfo': '', // Add profile information here
        //         'tiktokFollowers': '', // Add TikTok followers count here
        //         'tiktokURL': '', // Add TikTok URL account here
        //         'facebookFollowers': '', // Add Facebook followers count here
        //         'facebookURL': '', // Add Facebook URL account here
        //         'twitterFollowers': '', // Add Twitter followers count here
        //         'twitterURL': '', // Add Twitter URL account here
        //         'youTubeFollowers': '', // Add YouTube followers count here
        //         'youtubeURL': '', // Add youtube URL account here
        //         'instagramFollowers': '', // Add Instagram followers count here
        //         'instagramURL': '', // Add instagram URL account here
        //         'profileName': '', // Add profile name here
        //         'profileRate': 0.0, // Add profile rate here
        //       })
        //       .then((value) => print("User Added"))
        //       .catchError((error) => print("Failed to add user: $error"));
        // }

        //  var userID = await retrieveConstants('userID');

        // await FirebaseFirestore.instance
        //     .collection('users')
        //     .doc(userCredential.user?.uid)
        //     .set({
        //   'id': userID,
        //   'firstName': '${firstNameSignUpController.text}',
        //   'lastName': '${lastNameSignUpController.text}',
        //   'email': '${emailSignUpController.text}',
        //   'countryCode': '$countryCodeSignUp',
        //   'phoneNumber': '${phoneNumberSignUpController.text}',
        //   'totalSpentCoins': 0,
        //   'totalOrders': 0,
        //   'balance': 0,
        //   'userLevel': 1,
        //   'isSuspend': false,
        //   'createdAt': Timestamp.now(),
        //   'uid': userCredential.user?.uid,
        //   'referralCode':
        //       userCredential.user?.uid.substring(0, 12).toUpperCase(),
        // });

        await FirebaseFirestore.instance
            .collection('users')
            .doc(userCredential.user?.uid)
            .set({
          'id': userCredential.user?.uid,
          'FullName': fullNameController.text,
          'UserName': usernameController.text,
          'Email': emailController.text,
          // 'Password': passwordController.text,
          'DateOfBirth': dateOfBirthController.text,
          'phoneNumber': phoneNumberController.text,
          'AccountType': accountType, // Add selected account type
          'profileImage': '', // Add the profile image URL here
          'profileInfo': '', // Add profile information here
          'tiktokFollowers': '', // Add TikTok followers count here
          'tiktokURL': '', // Add TikTok URL account here
          'facebookFollowers': '', // Add Facebook followers count here
          'facebookURL': '', // Add Facebook URL account here
          'twitterFollowers': '', // Add Twitter followers count here
          'twitterURL': '', // Add Twitter URL account here
          'youTubeFollowers': '', // Add YouTube followers count here
          'youtubeURL': '', // Add youtube URL account here
          'instagramFollowers': '', // Add Instagram followers count here
          'instagramURL': '', // Add instagram URL account here
          'profileName': '', // Add profile name here
          'profileRate': 0.0, // Add profile rate here
          'createdAt': Timestamp.now(),
          'walletAmount': 0.0,
        });
        // await userCredential.user
        //     ?.updateDisplayName("${firstNameSignUpController.text}");

        await userCredential.user!.sendEmailVerification();

        Navigator.of(context).pop(); // dismiss the loading indicator

        // firstNameSignUpController.clear();
        // lastNameSignUpController.clear();
        // emailSignUpController.clear();
        // phoneNumberSignUpController.clear();
        // passwordSignUpController.clear();
        // rePasswordSignUpController.clear();

        CherryToast.success(
          title: Text(
            'signup_success'.tr(),
            // style: TextStyle(fontFamily: 'Righteous', color: primaryColor),
          ),
          toastPosition: Position.bottom,
          animationType: AnimationType.fromBottom,
        ).show(context);

        Future.delayed(Duration(seconds: 3), () {
          Navigator.pushReplacementNamed(
            context,
            '/login',
          );
        });

        return userCredential;
      } on FirebaseAuthException catch (e) {
        Navigator.of(context).pop(); // dismiss the loading indicator
        if (e.code == 'email-already-in-use') {
          CherryToast.error(
            title: Text(
              'ُemail_already_in_use'.tr(),
              // style: TextStyle(fontFamily: 'Righteous', color: primaryColor),
            ),
            toastPosition: Position.bottom,
            animationType: AnimationType.fromBottom,
          ).show(context);
        } else if (e.code == 'weak-password') {
          CherryToast.error(
            title: Text(
              'weak_password'.tr(),
              // style: TextStyle(fontFamily: 'Righteous', color: primaryColor),
            ),
            toastPosition: Position.bottom,
            animationType: AnimationType.fromBottom,
          ).show(context);
        } else if (e.code == 'invalid-email') {
          CherryToast.error(
            title: Text(
              'invalid_email'.tr(),
              // style: TextStyle(fontFamily: 'Righteous', color: primaryColor),
            ),
            toastPosition: Position.bottom,
            animationType: AnimationType.fromBottom,
          ).show(context);
        } else if (e.code == 'too-many-requests') {
          CherryToast.error(
            title: Text(
              'too_many_requests'.tr(),
              // style: TextStyle(fontFamily: 'Righteous', color: primaryColor),
            ),
            toastPosition: Position.bottom,
            animationType: AnimationType.fromBottom,
          ).show(context);
        }
      }
    } else {
      // print("Not Valid");
    }
  }
}