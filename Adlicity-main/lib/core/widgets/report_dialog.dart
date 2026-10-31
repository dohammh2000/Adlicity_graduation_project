import 'package:adlicity/core/widgets/main_button.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ReportDialog extends StatefulWidget {
  final String profileName;
  final String profileImage;

  const ReportDialog({
    super.key,
    required this.profileName,
    required this.profileImage,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController _reportController = TextEditingController();
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  @override
  void dispose() {
    _reportController.dispose();
    super.dispose();
  }

  Future<void> _saveReport(String message) async {
    try {
      // Get the current user's ID
      final userId = auth.currentUser?.uid;

      final DocumentReference reportRef = firestore.collection('reports').doc();

      // Set the data for the document
      await reportRef.set({
        'fromID': userId,
        'message': message,
        'toID': userId,
      });

      // Close the dialog
      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during the save process
      print('Error saving report: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: EdgeInsets.all(Constants.kPadding),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white,
          borderRadius: BorderRadius.circular(16.0),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Align(
              alignment: Alignment.topRight,
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Image.asset(
                  IconsAssets.close,
                  width: 12,
                ),
              ),
            ),
            CircleAvatar(
              backgroundImage:
                  NetworkImage(widget.profileImage), // Use NetworkImage here
              radius: 40,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              widget.profileName,
              style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                fontFamily: AppStrings.fontFamily,
              ),
            ),
            SizedBox(height: 15),
            TextFormField(
              controller: _reportController, // Use _reportController
              cursorColor: AppColors.primary,
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
                  borderSide: BorderSide(color: AppColors.primary),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(Constants.kRoundedCorner),
                  borderSide: BorderSide(color: AppColors.primary, width: 2),
                ),
              ),
              style: TextStyle(fontFamily: AppStrings.fontFamily),
              maxLines: 2,
            ),
            SizedBox(height: 22),
            MainButton(
              onPressed: () {
                _saveReport(_reportController.text);
              }, // Call the saveReport method on button press
              title: 'report',
            ),
          ],
        ),
      ),
    );
  }
}
