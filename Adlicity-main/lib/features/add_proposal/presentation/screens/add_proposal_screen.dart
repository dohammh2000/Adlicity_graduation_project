import 'package:adlicity/features/add_proposal/presentation/cubit/add_proposal_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/my_stepper.dart';

import '../widgets/done_step_proposal.dart';
import '../widgets/goal_step_proposal.dart';
import '../widgets/info_step_proposal.dart';
import '../widgets/resources_step_proposal.dart';

class AddProposalScreen extends StatelessWidget {
  const AddProposalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddProposalCubit, AddProposalState>(
      builder: (context, state) {
        AddProposalCubit cubit = BlocProvider.of(context);
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: Constants.kPadding),
            child: Column(
              children: [
                MyStepper(cubit: cubit),
                InfoStepProposal(cubit: cubit),
                ResourcesStepProposal(cubit: cubit),
                GoalStepProposal(cubit: cubit),
                DoneStepProposal(cubit: cubit),
              ], 
            ),
          ),
        );
      },
    );
  }
} 