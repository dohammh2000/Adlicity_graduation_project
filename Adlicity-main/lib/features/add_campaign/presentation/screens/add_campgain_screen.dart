import 'dart:io';

import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/app_strings.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/constants.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/core/widgets/category_button.dart';
import 'package:adlicity/core/widgets/input_field.dart';
import 'package:adlicity/core/widgets/main_button.dart';
import 'package:adlicity/features/add_campaign/presentation/cubit/add_campgain_cubit.dart';
import 'package:adlicity/features/add_campaign/presentation/widgets/info_step.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:easy_stepper/easy_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../../../core/widgets/my_stepper.dart';
import '../widgets/done_step.dart';
import '../widgets/goal_step.dart';
import '../widgets/resources_step.dart';

// // ignore: must_be_immutable
// class AddCampgainScreen extends StatelessWidget {
//   AddCampgainScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddCampgainCubit, AddCampgainState>(
//       builder: (context, state) {
//         AddCampgainCubit cubit = BlocProvider.of(context);
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
//             child: Column(
//               children: [
//                 MyStepper(cubit: cubit),
//                 InfoStep(cubit: cubit),
//                 ResourcesStep(cubit: cubit),
//                 GoalStep(cubit: cubit),
//                 DoneStep(cubit: cubit),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }
// ignore: must_be_immutable
// class AddCampgainScreen extends StatefulWidget {
//   AddCampgainScreen({Key? key}) : super(key: key);

//   @override
//   _AddCampgainScreenState createState() => _AddCampgainScreenState();
// }

// class _AddCampgainScreenState extends State<AddCampgainScreen> {
//   File? imageFile;

//   void _updateImageFile(File? newImageFile) {
//     setState(() {
//       imageFile = newImageFile;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AddCampgainCubit, AddCampgainState>(
//       builder: (context, state) {
//         AddCampgainCubit cubit = BlocProvider.of(context);
//         return SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
//             child: Column(
//               children: [
//                 MyStepper(cubit: cubit),
//                 InfoStep(cubit: cubit),
//                 ResourcesStep(
//                   cubit: cubit,
//                   imageFile: imageFile,
//                   onImageSelected: _updateImageFile,
//                 ),
//                 GoalStep(
//                   cubit: cubit,
//                   imageFile: imageFile,
//                   onImageSelected: _updateImageFile,
//                 ),
//                 DoneStep(cubit: cubit),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
// }

class AddCampgainScreen extends StatefulWidget {
  AddCampgainScreen({Key? key}) : super(key: key);

  @override
  _AddCampgainScreenState createState() => _AddCampgainScreenState();
}

class _AddCampgainScreenState extends State<AddCampgainScreen> {
  File? imageFile;

  void _updateImageFile(File? newImageFile) {
    Future.microtask(() {
      setState(() {
        imageFile = newImageFile;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AddCampgainCubit(),
      child: BlocListener<AddCampgainCubit, AddCampgainState>(
        listener: (context, state) {
          if (state is ImageSelectedState) {
            _updateImageFile(state.imageFile);
          }
        },
        child: BlocBuilder<AddCampgainCubit, AddCampgainState>(
          builder: (context, state) {
            AddCampgainCubit cubit = BlocProvider.of(context);
            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0), // Use your padding value here
                child: Column(
                  children: [
                    MyStepper(cubit: cubit),
                    InfoStep(cubit: cubit),
                    ResourcesStep(
                      cubit: cubit,
                      imageFile: imageFile,
                      onImageSelected: _updateImageFile,
                    ),
                    GoalStep(
                      cubit: cubit,
                      imageFile: imageFile,
                      onImageSelected: _updateImageFile,
                    ),
                    DoneStep(cubit: cubit),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}