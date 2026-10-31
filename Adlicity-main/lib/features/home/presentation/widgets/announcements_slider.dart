import 'package:adlicity/config/themes/app_colors.dart';
import 'package:adlicity/core/utils/media_query_values.dart';
import 'package:adlicity/features/home/presentation/cubit/home_cubit.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class AnnouncementsSlider extends StatelessWidget {
  const AnnouncementsSlider({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        HomeCubit cubit = BlocProvider.of(context);
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                height: 165.0,
                autoPlay: true,
                enlargeCenterPage: true,
                enlargeFactor: 0.2,
                autoPlayInterval: Duration(milliseconds: 4000),
                onPageChanged: (index, _) {
                  cubit.changeBannerIndex(index);
                },
              ),
              items: cubit.banners.map((i) {
                return Container(
                  width: context.width,
                  decoration:
                      BoxDecoration(borderRadius: BorderRadius.circular(15)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset(
                      i,
                      fit: BoxFit.cover,
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < cubit.banners.length; i++)
                  Container(
                    width: cubit.currentBannerIndex == i ? 20.0 : 4,
                    height: 4.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: cubit.currentBannerIndex == i
                          ? AppColors.primary
                          : AppColors.textColor.withOpacity(0.5),
                    ),
                  ),
              ],
            ),
          ],
        );
      },
    );
  }
}

// class AnnouncementsSlider extends StatefulWidget {
//   const AnnouncementsSlider({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _AnnouncementsSliderState createState() => _AnnouncementsSliderState();
// }

// class _AnnouncementsSliderState extends State<AnnouncementsSlider> {
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<HomeCubit, HomeState>(
//       builder: (context, state) {
//         HomeCubit cubit = BlocProvider.of(context);
//         return Column(
//           children: [
//             CarouselSlider(
//               options: CarouselOptions(
//                 height: 165.0,
//                 autoPlay: true,
//                 enlargeCenterPage: true,
//                 enlargeFactor: 0.2,
//                 autoPlayInterval: Duration(milliseconds: 4000),
//                 onPageChanged: (index, _) {
//                   cubit.changeBannerIndex(index);
//                 },
//               ),
//               items: cubit.banners.map((i) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   decoration:
//                       BoxDecoration(borderRadius: BorderRadius.circular(15)),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(15),
//                     child: Image.asset(
//                       i,
//                       fit: BoxFit.cover,
//                     ),
//                   ),
//                 );
//               }).toList(),
//             ),
//             SizedBox(height: 12),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 for (int i = 0; i < cubit.banners.length; i++)
//                   Container(
//                     width: cubit.currentBannerIndex == i ? 20.0 : 4,
//                     height: 4.0,
//                     margin: EdgeInsets.symmetric(horizontal: 4.0),
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(20),
//                       color: cubit.currentBannerIndex == i
//                           ? AppColors.primary
//                           : AppColors.textColor.withOpacity(0.5),
//                     ),
//                   ),
//               ],
//             ),
//           ],
//         );
//       },
//     );
//   }
// }
