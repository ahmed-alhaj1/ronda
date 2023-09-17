import 'package:flutter/material.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:page_transition/page_transition.dart';
import 'package:ronda/pages/profile.dart';
import 'package:ronda/chats/recent_chats.dart';
import 'package:ronda/screens/settings.dart';
import 'package:ronda/screens/edit_profile.dart';

class SidebarProvider {
  //static const String Login = '/Login';
  static const String home = '/home';
  static const String edit_profile = '/EditProfile';
  static const String chat = '/chat';
  static const String calendar = '/calendar';
  static const String schedule_workout = '/schedule_workout';
  static const String meeting_schedular = '/meeting-schedular';

  currentUserId() {
    return firebaseAuth.currentUser!.uid;
  }

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case home:
        return PageTransition(
          child: Profile(profileId: firebaseAuth.currentUser!.uid),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case edit_profile:
        return PageTransition(
          child: EditProfile(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case chat:
        return PageTransition(
          child: Chats(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      /*case calendar:
        return PageTransition(
          child: ProviderCalendar(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case Login:
        return PageTransition(
          child: ProviderLogin(),
          type: PageTransitionType.fade,
          settings: settings,
        );

      case schedule_workout:
        return PageTransition(
          child: ProviderAddMeeting(),
          type: PageTransitionType.fade,
          settings: settings,
        );
      case meeting_schedular:
        return PageTransition(
          child: MeetingSchedular(),
          type: PageTransitionType.fade,
          settings: settings,
        );*/
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Container(),
          ),
        );
    }
  }
}
