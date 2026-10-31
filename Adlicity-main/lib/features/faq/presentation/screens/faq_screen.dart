import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../../core/utils/assets_manager.dart';




class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  //! Don't Forget to rotate and animate arrow button for the tile

  @override
  Widget build(BuildContext context) {
     final faqCubit = BlocProvider.of<FaqCubit>(context);

      // useEffect(() {
      //   faqCubit.fetchDataFromFirebase();
      // }, []);
    
    return Scaffold(
      appBar: AppBar(
        title: Text('FAQ'),
        leading: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Image.asset(
            IconsAssets.arrowLeft,
            width: 25,
          ),
        ),
      ),
      body: BlocBuilder<FaqCubit, FaqState>(
      builder: (context, state) {
          if (state is FaqLoaded) {
              final faqData = state.faqData;

              // Render the fetched data in your UI components
            return SingleChildScrollView(

            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
              child: SizedBox(
                width: context.width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 40,
                    ),
                    Image.asset(
                      ImagesAssets.fqaAva,
                      width: 250,
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    ListView.separated(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                   itemBuilder: (context, index) => _buildTileItem(faqData[index]), // Convert to FAQ before passing
                        separatorBuilder: (context, index) => Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          child: Divider(
                                color: AppColors.primary,
                                thickness: 1.0,
                                height: 20,
                              ),
                        ),
                       itemCount: state.faqData.length,
                      ),
                    ],
                  ),
                ),
              ),
            );
          } else if (state is FaqError) {
            return Center(
              child: Text('Failed to load FAQs.'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(
                color: AppColors.primary,
              ),
            );
          }
        },
      ),
    );
  }


    ExpansionTileCard _buildTileItem(faq) {
    return ExpansionTileCard(
      trailing: Image.asset(
        IconsAssets.arrowDown,
        width: 20,
      ),
      baseColor: Colors.white,
      expandedColor: Colors.white,
      key: GlobalKey(),
      title: Text(
        faq['question'],
        style: TextStyle(
            color: AppColors.primary, fontFamily: AppStrings.fontFamily),
      ),
      children: [
        const Divider(
          thickness: 1.0,
          height: 1.0,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 16.0,
              vertical: 8.0,
            ),
            child: Text(
              faq['answer'],
              style: TextStyle(
                  color: AppColors.textColor,
                  fontFamily: AppStrings.fontFamily),
            ),
          ),
        ),
      ],
    );
  }
}