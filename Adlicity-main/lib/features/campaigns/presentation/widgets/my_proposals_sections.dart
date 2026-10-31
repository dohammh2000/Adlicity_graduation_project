import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/assets_manager.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../../../../core/utils/constants.dart';
import '../../../../core/widgets/proposal_full_item.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MyProposalsSection extends StatelessWidget {
  const MyProposalsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CampaignCubit()..getProposalsWithCreatorData(),
      child: BlocBuilder<CampaignCubit, CampaignState>(
        builder: (context, state) {
          if (state is CampaignInitial) {
            return Center(child: CircularProgressIndicator());
          } else 
          if (state is Loading) {
            return Center(child: CircularProgressIndicator());
          } else if (state is proposalError) {
            return Center(child: Text('Error: ${state.message}'));
          } else if (state is ProposalLoaded) {
            return ListView.separated(
              padding: EdgeInsets.only(top: 20),
              itemBuilder: (context, index) => SwipeAndStopWidget(
                proposalData: state.proposals[index],
              ),
              separatorBuilder: (context, index) => SizedBox(height: 20),
              itemCount: state.proposals.length,
            );
          } else {
            return Center(child: Text('No proposals found.'));
          }
        },
      ),
    );
  }
}

class SwipeAndStopWidget extends StatefulWidget {
  final Map<String, dynamic> proposalData;

  SwipeAndStopWidget({required this.proposalData});

  @override
  _SwipeAndStopWidgetState createState() => _SwipeAndStopWidgetState();
}

class _SwipeAndStopWidgetState extends State<SwipeAndStopWidget> {
  double _xOffset = 0.0;
  double _initialXOffset = 0.0;
  bool _isSwiped = false;

  @override
  Widget build(BuildContext context) {

    
    return SizedBox(
      height: 280,
      child: GestureDetector(
        onHorizontalDragStart: (details) {
          _initialXOffset = _xOffset;
        },
        onHorizontalDragUpdate: (details) {
          setState(() {
            _xOffset = details.globalPosition.dx - _initialXOffset;
          });
        },
        onHorizontalDragEnd: (details) {
          if (_xOffset < MediaQuery.of(context).size.width / 3) {
            setState(() {
              _isSwiped = true;
            });
          } else {
            setState(() {
              _isSwiped = false;
              _xOffset = 0.0;
            });
          }
        },
        child: Stack(
          children: [
            AnimatedPositioned(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              left: _isSwiped
                  ? -MediaQuery.of(context).size.width / 2
                  : -_xOffset,
              child: ProposalFullItem(
                bottomLeftRadius: 0, 
                bottomRightRadius: 0, 
                topLeftRadius: 0,
                category: widget.proposalData['proposalData']['category'] ??
                    'Unknown',
                description: widget.proposalData['proposalData']
                        ['Description'] ??
                    'Unknown',
                facebookFollowers: widget.proposalData['creatorData']
                        ['facebookFollowers'] ??
                    '1',
                instagramFollowers: widget.proposalData['creatorData']
                        ['instagramFollowers'] ??
                    '2',
                price: widget.proposalData['proposalData']['price'] ?? '0.0',
                profileImage://Constants.proposalsTest[0]['profileImage'],
                 widget.proposalData['creatorData']
                        ['profileImage'] ??
                    'Unknown',
                profileInfo: widget.proposalData['creatorData']
                        ['profileInfo'] ??
                    'Unknown',
                profileName: widget.proposalData['creatorData']
                        ['profileName'] ??
                    'Unknown',
                profileRate:
                    widget.proposalData['creatorData']['profileRate'] ?? '0.0',
                tiktokFollowers: widget.proposalData['creatorData']
                        ['tiktokFollowers'] ??
                    '1',
                title:
                    widget.proposalData['proposalData']['Title'] ?? 'Unknown',
                twitterFollowers: widget.proposalData['creatorData']
                        ['twitterFollowers'] ??
                    '0',
                youTubeFollowers: widget.proposalData['creatorData']
                        ['youTubeFollowers'] ??
                    '0',
              ),
            ),
            if (_isSwiped)
              Positioned(
                top: 120,
                right: MediaQuery.of(context).size.width * 0.14,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: IconButton(
                        onPressed: () {
                          final cubit = context.read<CampaignCubit>();
                          cubit.applyToProposalsection(widget
                              .proposalData['proposalData']['proposalId']);
                          setState(() {
                            _isSwiped = false;
                            _xOffset = 0.0;
                          });
                        },
                        icon: Icon(Icons.check),
                        color: Colors.white,
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                      ),

                      // IconButton(
                      //   onPressed: () {
                      //     setState(() {
                      //       _isSwiped = false;
                      //       _xOffset = 0.0;
                      //     });
                      //   },
                      //   icon: Icon(Icons.edit),
                      //   color: Colors.white,
                      //   iconSize: 20,
                      //   padding: EdgeInsets.zero,
                      //   splashRadius: 20,
                      // ),
                    ),
                    SizedBox(width: MediaQuery.of(context).size.width * 0.02),
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child:
                          //  IconButton(
                          //   onPressed: () {
                          //     setState(() {
                          //       _isSwiped = false;
                          //       _xOffset = 0.0;
                          //     });
                          //   },
                          //   icon: Icon(Icons.delete),
                          //   color: Colors.white,
                          //   iconSize: 20,
                          //   padding: EdgeInsets.zero,
                          //   splashRadius: 20,
                          // ),
                          IconButton(
                         onPressed: () {
    final cubit = context.read<CampaignCubit>();

    // Retrieve the 'applicants' map from widget.proposalData
    Map<String, dynamic>? applicantsMap = widget.proposalData['proposalData']['applicants'] as Map<String, dynamic>?;

    if (applicantsMap != null) {
      // Extract keys (IDs) from applicantsMap
      List<String> applicantIds = applicantsMap.keys.toList();

      cubit.rejectproposal(
        widget.proposalData['proposalData']['proposalId'],
        applicantIds,
      );
    } else {
      print('Error: Applicants map is null or not a valid map.');
    }
                          
                          setState(() {
                            _isSwiped = false;
                            _xOffset = 0.0;
                          });
                        },
                        icon: Icon(Icons.close),
                        color: Colors.white,
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        splashRadius: 20,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
