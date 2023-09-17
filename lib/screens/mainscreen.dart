import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ronda/components/fab_container.dart';
//import 'package:ronda/pages/notification.dart';
import 'package:ronda/pages/profile.dart';
import 'package:ronda/pages/search.dart';
import 'package:ronda/pages/feeds.dart';
import 'package:ronda/pages/portfolio.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:ronda/widgets/responsive.dart';
import 'package:ronda/widgets/top_bar.dart';
import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';

class TabScreen extends StatefulWidget {
  @override
  _TabScreenState createState() => _TabScreenState();
}

class _TabScreenState extends State<TabScreen> {
  double _opacity = 0;
  int _page = 0;

  List pages = [
    {
      'title': 'Home',
      'icon': Ionicons.home,
      'page': Feeds(),
      'index': 0,
    },
    {
      'title': 'Search',
      'icon': Ionicons.search,
      'page': Search(),
      'index': 1,
    },
    {
      'title': 'unsee',
      'icon': Ionicons.add_circle,
      'page': const Text('Main'),
      'index': 2,
    },

    /*
    // Portfolio(portfolioId: firebaseAuth.currentUser!.uid),
    {
      'title': 'Notification',
      'icon': CupertinoIcons.bell_solid,
      'page': Activities(),
      'index': 3,
    },*/

    {
      'title': 'Profile',
      'icon': CupertinoIcons.person_fill,
      'page': Profile(profileId: firebaseAuth.currentUser!.uid),
      'index': 3,
    },
  ];

  @override
  Widget build(BuildContext context) {
    _opacity = 1;
    var screenSize = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Theme.of(context).secondaryHeaderColor,
      extendBodyBehindAppBar: true,
      appBar: ResponsiveWidget.isSmallScreen(context)
          ? AppBar(
              backgroundColor: Theme.of(context).bottomAppBarTheme.shadowColor,
              elevation: 0,
              centerTitle: true,
              actions: [
                IconButton(
                  icon: Icon(Icons.brightness_6),
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    EasyDynamicTheme.of(context).changeTheme();
                  },
                ),
              ],
              title: Text(
                'Expolore',
                style: TextStyle(
                  color: Colors.blueGrey[100],
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  fontWeight: FontWeight.w400,
                  letterSpacing: 3,
                ),
              ),
            )
          : null,
      body: PageTransitionSwitcher(
        transitionBuilder: (
          Widget child,
          Animation<double> animation,
          Animation<double> secondaryAnimation,
        ) {
          return FadeThroughTransition(
            animation: animation,
            secondaryAnimation: secondaryAnimation,
            child: child,
          );
        },
        child: pages[_page]['page'],
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(width: 5),
            for (Map item in pages)
              item['index'] == 2
                  ? buildFab()
                  : Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: IconButton(
                        icon: Icon(
                          item['icon'],
                          color: item['index'] != _page
                              ? Theme.of(context).brightness == Brightness.dark
                                  ? Colors.white
                                  : Colors.black
                              : Theme.of(context).colorScheme.secondary,
                          size: 25.0,
                        ),
                        onPressed: () => navigationTapped(item['index']),
                      ),
                    ),
            SizedBox(width: 5),
          ],
        ),
      ),
    );
  }

  buildFab() {
    return Container(
      height: 45.0,
      width: 45.0,
      // ignore: missing_required_param
      child: FabContainer(
        icon: Ionicons.add_outline,
        mini: true,
      ),
    );
  }

  void navigationTapped(int page) {
    setState(() {
      _page = page;
    });
  }
}
