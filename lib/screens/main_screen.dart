import 'package:animations/animations.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ronda/components/fab_container.dart';
import 'package:ronda/components/profile_card.dart';
import 'package:ronda/components/sidebar.dart';
//import 'package:ronda/pages/notification.dart';
import 'package:ronda/pages/profile.dart';
//import 'package:ronda/pages/search.dart';
import 'package:ronda/pages/feeds.dart';
import 'package:ronda/pages/portfolio.dart';
import 'package:ronda/utils/firebase.dart';
//import 'package:ronda/widgets/top_bar.dart';
//import 'package:easy_dynamic_theme/easy_dynamic_theme.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:ronda/components/manuController.dart';
import 'package:provider/provider.dart';
import 'package:ronda/utils/responsive.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TabController? tabController;
  ItemScrollController? itemScrollController;

  var scaffoldKey = GlobalKey<ScaffoldState>();
  double? screenHeight;
  double? screenWidth;
  double? topPadding;
  double? bottomPadding;
  double? sidePadding;

  List<ContentView> pages = [
    ContentView(
      tab: CustomTab(title: 'Home'),
      content: Feeds(),
    ),
    ContentView(
      tab: CustomTab(title: 'profile'),
      content: Profile(),
    ),
    ContentView(
      tab: CustomTab(title: 'Portfolio'),
      content: Portfolio(portfolioId: firebaseAuth.currentUser!.uid),
    )
  ];
  List pagess = [
    {
      'title': 'Home',
      'icon': Ionicons.home,
      'page': Feeds(),
      'index': 0,
    },

    /*{
      'title': 'Search',
      'icon': Ionicons.search,
      'page': Search(),
      'index': 1,
    },
    
    {
      'title': 'unsee',
      'icon': Ionicons.add_circle,
      'page': const Text('Main'),
      'index': 1,
    },
    */

    /*{
      'title': 'Notification',
      'icon': CupertinoIcons.bell_solid,
      'page': Activities(),
      'index': 3,
    },*/

    {
      'title': 'Profile',
      'icon': CupertinoIcons.person_fill,
      'page': Portfolio(portfolioId: firebaseAuth.currentUser!.uid),
      'index': 1,
    },
  ];

  //List<ContentView> contentViews = []

  @override
  void initState() {
    super.initState();
    //tabController = TabController(length: 4, vsync: this);
    //itemScrollController = ItemScrollController();
  }
/*
  @override
  // ignore: must_call_super
  void didChangeDependencies() {}
*/

  @override
  Widget build(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
    screenHeight = MediaQuery.of(context).size.height;
    topPadding = screenHeight! * 0.05;
    bottomPadding = screenHeight! * 0.03;
    sidePadding = screenWidth! * 0.05;

    print('Width: $screenWidth');
    print('Height: $screenHeight');

    //tabController = TabController(length: pages.length, vsync: this);
    itemScrollController = ItemScrollController();

    return Scaffold(
      //backgroundColor: Color(0xff1e1e24),
      key: context.read<MenuAppController>().scaffoldKey,
      //endDrawer: drawer(),
      appBar: !Responsive.isDesktop(context)
          ? AppBar(
              backgroundColor: Theme.of(context).primaryColorLight,
            )
          : null,
      drawer: const SideMenu(),
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // We want this side menu only for large screen
            if (Responsive.isDesktop(context))
              Expanded(
                // default flex = 1
                // and it takes 1/6 part of the screen
                child: SideMenu(),
              ),

            Expanded(
              flex: 3,
              child: Feeds(),
            ),

            // Expanded(
            //   // It takes 5/6 part of the screen
            //   flex: 1,
            //   child: ProfileCard(),
            // ),
          ],
        ),
      ),
    );
  }

  Widget mobileView() {
    return Padding(
      padding: EdgeInsets.only(left: sidePadding!, right: sidePadding!),
      child: Expanded(
        child: Container(
          width: screenWidth,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              IconButton(
                  iconSize: screenWidth! * 0.08,
                  icon: Icon(Icons.menu_rounded),
                  color: Colors.white,
                  splashColor: Colors.transparent,
                  onPressed: () => scaffoldKey.currentState!.openEndDrawer()),
              Expanded(
                child: ScrollablePositionedList.builder(
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemScrollController: itemScrollController,
                  itemCount: pages.length,
                  itemBuilder: (context, index) => pages[index].content,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget desktopView() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        /// Tab Bar
        Container(
          height: screenHeight! * 0.05,
          child: CustomTabBar(
              controller: tabController!,
              tabs: pages.map((e) => e.tab).toList()),
        ),

        /// Tab Bar View

        Container(
          height: screenHeight! * 0.8,
          child: TabControllerHandler(
            tabController: tabController!,
            child: TabBarView(
              controller: tabController,
              children: pages.map((e) => e.content).toList(),
            ),
          ),
        ),

        /// Bottom Bar
        //BottomBar()
      ],
    );
  }

//####################################################################################

  Widget drawer() {
    return Container(
      width: screenWidth! * 0.5,
      child: Drawer(
        child: ListView(
          shrinkWrap: true,
          children: [Container(height: screenHeight! * 0.1)] +
              pages
                  .map((e) => Container(
                        child: ListTile(
                          title: Text(
                            e.tab.title,
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                          onTap: () {
                            itemScrollController!.scrollTo(
                                index: pages.indexOf(e),
                                duration: Duration(milliseconds: 300));
                            Navigator.pop(context);
                          },
                        ),
                      ))
                  .toList(),
        ),
      ),
    );
  }
}

//####################################################################
class ContentView {
  ContentView({required this.tab, required this.content});

  final CustomTab tab;
  final Widget content;
}

//####################################################################
class CustomTab extends StatelessWidget {
  CustomTab({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Tab(child: Text(this.title, style: TextStyle(fontSize: 16)));
  }
}

class TabControllerHandler extends InheritedWidget {
  final TabController tabController;

  TabControllerHandler({
    Key? key,
    required this.tabController,
    Widget? child,
  }) : super(key: key, child: child!);

  static TabControllerHandler of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<TabControllerHandler>()!;
  }

  @override
  bool updateShouldNotify(TabControllerHandler oldWidget) {
    return oldWidget.tabController != tabController;
  }
}

class CustomTabBar extends StatelessWidget {
  CustomTabBar({required this.controller, required this.tabs});

  final TabController controller;
  final List<Widget> tabs;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double tabBarScaling = screenWidth > 1400
        ? 0.21
        : screenWidth > 1100
            ? 0.3
            : 0.4;
    return Padding(
      padding: EdgeInsets.only(right: screenWidth * 0.05),
      child: Container(
        width: screenWidth * tabBarScaling,
        child: Theme(
          data: ThemeData(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              hoverColor: Colors.transparent),
          child: TabBar(
            indicatorSize: TabBarIndicatorSize.tab,
            controller: controller,
            indicatorColor: Color(0xff21a179),
            tabs: tabs,
          ),
        ),
      ),
    );
  }
}

class BottomBar extends StatelessWidget {
  const BottomBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Align(
            alignment: Alignment.center,
            child: Container(
              height: 2,
              width: screenWidth * 0.9,
              color: Colors.white,
            )),
        Container(
          height: screenHeight * 0.05,
          child: Padding(
            padding: EdgeInsets.only(
                left: screenWidth * 0.05, right: screenWidth * 0.05),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    CustomIconButton(
                      iconData: FontAwesomeIcons.youtube,
                      url:
                          'https://www.youtube.com/channel/UCcrXelEbe1HEZb0Olqy7jGg',
                      color: Colors.red,
                    ),
                    SizedBox(width: screenWidth * 0.021),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.github,
                      url: 'https://github.com/FlorianPruemer',
                      color: Colors.white,
                    ),
                    SizedBox(width: screenWidth * 0.02),
                    CustomIconButton(
                      iconData: FontAwesomeIcons.linkedin,
                      url: 'https://www.linkedin.com/in/FlorianPruemer/',
                      color: Colors.blue,
                    )
                  ],
                ),
                Text('Made with Flutter Web \u00a9 2021',
                    style: TextStyle(color: Colors.white, fontFamily: 'Barlow'))
              ],
            ),
          ),
        )
      ],
    );
  }
}

class CustomIconButton extends StatelessWidget {
  const CustomIconButton(
      {Key? key,
      required this.iconData,
      required this.url,
      required this.color})
      : super(key: key);
  final IconData iconData;
  final String url;
  final Color color;

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return IconButton(
      icon: FaIcon(iconData),
      onPressed: () => openURL(url),
      iconSize: screenHeight * 0.05,
      color: color,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
    );
  }

  void openURL(String url) async {
    await canLaunch(url) ? await launch(url) : throw 'Could not launch $url';
  }
}

class ViewWrapper extends StatelessWidget {
  const ViewWrapper(
      {Key? key, required this.desktopView, required this.mobileView})
      : super(key: key);
  final Widget desktopView;
  final Widget mobileView;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > 715 &&
          MediaQuery.of(context).size.height > 550) {
        return desktopView;
      } else {
        return mobileView;
      }
    });
  }
}
