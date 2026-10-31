import 'package:adlicity/core/widgets/main_button.dart';
import 'package:animated_rating_stars/animated_rating_stars.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

import '../../config/themes/app_colors.dart';
import '../utils/app_strings.dart';
import '../utils/assets_manager.dart';
import '../utils/constants.dart';
import '../utils/functions/get_rating_text.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RateDialog extends StatefulWidget {
  final String profileName;
  final String profileImage;
  final String userId;

  const RateDialog({
    super.key,
    required this.profileName,
    required this.profileImage,
    required this.userId,
  });

  @override
  State<RateDialog> createState() => _RateDialogState();
}

class _RateDialogState extends State<RateDialog> {
  double? _rating;

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    super.initState();
    _rating = 0.0; // Initialize to a default value
  }

  Future<void> _saveRating(double rating, String userId) async {
    try {
      // Get the current user's ID
      // final User? user = FirebaseAuth.instance.currentUser;
      // final String userId = user?.uid ?? '';

      if (userId.isEmpty) {
        print('No user ID found');
        return;
      }

      // Reference to the user's document in Firestore
      final DocumentReference userDoc =
          FirebaseFirestore.instance.collection('users').doc(userId);

      // Get the current profile rating
      DocumentSnapshot userSnapshot = await userDoc.get();
      double currentRating = userSnapshot.get('profileRate') ?? 0.0;

      // Calculate the new average rating
      double newRating = (currentRating + rating) / 2;

      // Update the profileRate field with the new rating
      await userDoc.update({'profileRate': newRating});

      Navigator.pop(context);
    } catch (e) {
      // Handle any errors that occur during the save process
      print('Error saving rating: $e');
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
              backgroundImage: NetworkImage(widget.profileImage),
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
            AnimatedRatingStars(
              initialRating: 0,
              minRating: 0.0,
              maxRating: 5.0,
              filledColor: Colors.amber,
              emptyColor: AppColors.textColor,
              filledIcon: Icons.star,
              halfFilledIcon: Icons.star_half,
              emptyIcon: Icons.star_border,
              onChanged: (double rating) {
                // Handle the rating change here
                // print('Rating: $rating');
                setState(() {
                  // Update state with new rating
                  _rating = rating;
                });
              },
              interactiveTooltips: true,
              customFilledIcon: Icons.star,
              customHalfFilledIcon: Icons.star_half,
              customEmptyIcon: Icons.star_border,
              starSize: 30.0,
              animationDuration: Duration(milliseconds: 300),
              animationCurve: Curves.easeInOut,
              readOnly: false,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              getRatingText(_rating!).tr(),
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
                color: AppColors.textColor,
                fontFamily: AppStrings.fontFamily,
              ),
            ),
            SizedBox(height: 22),
            MainButton(
              onPressed: () {
                _saveRating(
                  _rating!,
                  widget.userId,
                );

                // Navigator.pop(context);
              },
              title: 'Rate ${widget.profileName.split(' ')[0]}',
            )
          ],
        ),
      ),
    );
  }
}
