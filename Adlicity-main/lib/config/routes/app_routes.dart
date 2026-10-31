import 'package:adlicity/features/add_campaign/presentation/cubit/add_campgain_cubit.dart';
import 'package:adlicity/features/add_proposal/presentation/cubit/add_proposal_cubit.dart';
import 'package:adlicity/features/add_proposal/presentation/screens/add_proposal_screen.dart';
import 'package:adlicity/features/campaigns/presentation/cubit/campaign_cubit.dart';
import 'package:adlicity/features/campaigns/presentation/screens/campaign_details_screen.dart';
import 'package:adlicity/features/campaigns/presentation/screens/campaigns_screen.dart';
import 'package:adlicity/features/chat/presentation/cubit/chat_cubit.dart';
import 'package:adlicity/features/chat/presentation/screens/chat_details_screen.dart';
import 'package:adlicity/features/chat/presentation/screens/chats_screen.dart';
//import 'package:adlicity/features/faq/%20FAQService.dart';
import 'package:adlicity/features/faq/presentation/cubit/faq_cubit.dart';
import 'package:adlicity/features/faq/presentation/screens/faq_screen.dart';
import 'package:adlicity/features/login/presentation/cubit/login_cubit.dart';
import 'package:adlicity/features/login/presentation/screens/login_screen.dart';
import 'package:adlicity/features/main_layout/presentation/cubit/main_layout_cubit.dart';
import 'package:adlicity/features/main_layout/presentation/screens/main_layout.dart';
import 'package:adlicity/features/otp/presentation/cubit/otp_cubit.dart';
import 'package:adlicity/features/otp/presentation/screens/otp_screen.dart';
import 'package:adlicity/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:adlicity/features/profile/presentation/screens/profile_details_screen.dart';
import 'package:adlicity/features/profile/presentation/screens/profile_screen.dart';
import 'package:adlicity/features/search/presentation/cubit/search_cubit.dart';
import 'package:adlicity/features/search/presentation/screens/search_screen.dart';
import 'package:adlicity/features/settings/presentation/cubit/settings_cubit.dart';
import 'package:adlicity/features/settings/presentation/screens/settings_screen.dart';
import 'package:adlicity/features/sign_up/presentation/cubit/sign_up_cubit.dart';
import 'package:adlicity/features/sign_up/presentation/screens/sign_up_screen.dart';
import 'package:adlicity/features/trending/presentation/cubit/trending_cubit.dart';
import 'package:adlicity/features/trending/presentation/screens/trending_screen.dart';
import 'package:adlicity/features/wallet/presentation/cubit/wallet_cubit.dart';
import 'package:adlicity/features/wallet/presentation/screens/wallet_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:page_transition/page_transition.dart';

import '../../core/utils/app_strings.dart';
import '../../features/add_campaign/presentation/screens/add_campgain_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/splash/presentation/screens/splash_screen.dart';


class Routes {
  static const String initialRoute = '/';
  static const String homeRoute = '/home';
  static const String faqRoute = '/faq';
  static const String campaignsRoute = '/campaigns';
  static const String campaignDetailsRoute = '/campaignDetails';
  static const String addCampgainRoute = '/addCampgain';
  static const String addProposalRoute = '/addProposal';
  static const String walletRoute = '/wallet';
  static const String profileRoute = '/profile';
  static const String profileDetailsRoute = '/profileDetails';
  static const String loginRoute = '/login';
  static const String otpRoute = '/otp';
  static const String signUpRoute = '/signUp';
  static const String trendingRoute = '/trending';
  static const String settingsRoute = '/settings';
  static const String searchRoute = '/search';
  static const String chatRoute = '/chat';
  static const String chatDetailsRoute = '/chatDetails';
  static const String testRoute = '/test';
}

class AppRoutes {
  static Route? onGenerateRoute(RouteSettings routeSettings) {
        final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final FirebaseAuth auth = FirebaseAuth.instance;
   final FirebaseStorage firebaseStorage = FirebaseStorage.instance;

    switch (routeSettings.name) {
      case Routes.initialRoute:
        return MaterialPageRoute(builder: (context) {
          return SplashScreen();
        });

      case Routes.homeRoute:
        return MaterialPageRoute(builder: ((context) {
          final User? user = FirebaseAuth.instance.currentUser;
          if (user != null) {
            return BlocProvider<MainLayoutCubit>(
              create: (context) => MainLayoutCubit(
                firebaseService: FirebaseService(),
                user: user, // Dynamically fetch the userId here
              ),
              child: MainLayout(user: user), // Pass the userId to MainLayout
            );
          } else {
            // Handle case where user is not signed in
            return Container(); // Placeholder widget or navigate to sign-in screen
          }
        }));
      case Routes.campaignsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<CampaignCubit>(
            create: (context) => CampaignCubit(),
            child: CampaignsScreen(),
          );
        }));
      case Routes.settingsRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<SettingsCubit>(
            create: (context) => SettingsCubit(),
            child: SettingsScreen(),
          );
        }));
      case Routes.searchRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<SearchCubit>(
            create: (context) => SearchCubit(),
            child: SearchScreen(),
          );
        }));
      case Routes.campaignDetailsRoute:
        return MaterialPageRoute(builder: (context) {
          // Retrieve the arguments from the settings
          final Map<String, dynamic>? args =
              routeSettings.arguments as Map<String, dynamic>?;

          // If arguments are null, handle the case accordingly
          if (args == null) {
            // Return some default screen or handle the error
            return Scaffold(
              body: Center(
                child: Text('Error: No data passed!'),
              ),
            );
          }
          print('Arguments: $routeSettings.args');
          // If arguments are provided, construct the CampaignDetailsScreen with the passed data
          return BlocProvider<CampaignCubit>(
            create: (context) => CampaignCubit(),
            child: CampaignDetailsScreen(
              cubit: args,
              status: args['status'],
              date: args['date'],
              title: args['title'],
              description: args['description'],
              category: args['category'],
              adTypes: args['adTypes'],
              price: args['price'],
              link: args['link'],
              applicantsData: args,
              campaignData: args,
            ),
          );
        });

      case Routes.addCampgainRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<AddCampgainCubit>(
            create: (context) => AddCampgainCubit(),
            child: AddCampgainScreen(),
          );
        }));

      case Routes.chatRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<ChatCubit>(
            create: (context) =>
                ChatCubit(firestore, auth, firebaseStorage)..loadChats(),
            child: ChatsScreen(),
          );
        }));

      case Routes.chatDetailsRoute:
        final chatId = routeSettings.arguments as String;
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<ChatCubit>(
            create: (context) => ChatCubit(firestore, auth,firebaseStorage)..loadChats(),
            child: ChatDetailsScreen(chatId: chatId),
          );
        }));

      case Routes.addProposalRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<AddProposalCubit>(
            create: (context) => AddProposalCubit(),
            child: AddProposalScreen(),
          );
        }));
      case Routes.walletRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<WalletCubit>(
            create: (context) => WalletCubit(),
            child: WalletScreen(),
          );
        }));
      case Routes.profileRoute:
        return MaterialPageRoute(builder: (context) {
          // Retrieve the arguments from the settings
          final Map<String, dynamic>? args =
              routeSettings.arguments as Map<String, dynamic>?;

          // If arguments are null, handle the case accordingly
          if (args == null) {
            // Return some default screen or handle the error
            return Scaffold(
              body: Center(
                child: Text('Error: No data passed!'),
              ),
            );
          }
          // If arguments are provided, construct the CampaignDetailsScreen with the passed data
          return BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
            child: ProfileScreen(
            
            ),
          );
        });

      case Routes.profileDetailsRoute:
        return MaterialPageRoute(builder: (context) {
          // Retrieve the arguments from the settings
          final Map<String, dynamic>? args =
              routeSettings.arguments as Map<String, dynamic>?;

          // If arguments are null, handle the case accordingly
          if (args == null) {
            // Return some default screen or handle the error
            return Scaffold(
              body: Center(
                child: Text('Error: No data passed!'),
              ),
            );
          }
          // If arguments are provided, construct the CampaignDetailsScreen with the passed data
          return BlocProvider<ProfileCubit>(
            create: (context) => ProfileCubit(),
            child: ProfileDetailsScreen(
              facebookFollowers: args['facebookFollowers'],
              instagramFollowers: args['instagramFollowers'],
              profileImage: args['profileImage'],
              profileInfo: args['profileInfo'],
              profileName: args['profileName'],
              profileRate: args['profileRate'],
              tiktokFollowers: args['tiktokFollowers'],
              twitterFollowers: args['twitterFollowers'],
              youTubeFollowers: args['youTubeFollowers'],
            ),
          );
        });
      case Routes.loginRoute:
        return PageTransition(
          child: BlocProvider<LoginCubit>(
            create: (context) => LoginCubit(),
            child: LoginScreen(),
          ),
          type: PageTransitionType.fade, // Specify the transition type
          duration: Duration(
              milliseconds: 500), // Specify the duration of the transition
          curve: Curves.easeInOut, // Specify the curve of the transition
        );
      case Routes.otpRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<OtpCubit>(
            create: (context) => OtpCubit(),
            child: OtpScreen(),
          );
        }));
      case Routes.signUpRoute:
        return PageTransition(
          child: BlocProvider<SignUpCubit>(
            create: (context) => SignUpCubit(),
            child: SignUpScreen(),
          ),
          type: PageTransitionType.fade, // Specify the transition type
          duration: Duration(
              milliseconds: 500), // Specify the duration of the transition
          curve: Curves.easeInOut, // Specify the curve of the transition
        );
  

  case Routes.faqRoute:
  return MaterialPageRoute(builder: ((context) {
    return BlocProvider<FaqCubit>(
      create: (context) => FaqCubit()..fetchFAQData(), // Remove faqService parameter
      child: const FaqScreen(),
    );
  }));

      case Routes.trendingRoute:
        return MaterialPageRoute(builder: ((context) {
          return BlocProvider<TrendingCubit>(
            create: (context) => TrendingCubit(),
            child: TrendingScreen(),
          );
        }));
   
      default:
        return undefinedRoute();
    }
  }

  static Route<dynamic> undefinedRoute() {
    return MaterialPageRoute(
        builder: ((context) => const Scaffold(
              body: Center(
                child: Text(AppStrings.noRouteFound),
              ),
            )));
  }
}
