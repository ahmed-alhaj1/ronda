import 'package:flutter/material.dart';
import 'package:feather_icons/feather_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ronda/pages/profile.dart';
import 'package:page_transition/page_transition.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
          ),
          DrawerListTile(
            title: "Dashboard",
            icon: CupertinoIcons.folder_badge_person_crop,
            press: () {},
          ),
          DrawerListTile(
            title: "Transaction",
            icon: CupertinoIcons.money_dollar,
            press: () {},
          ),
          /*
          DrawerListTile(
            title: "Task",
            icon:  feather,
            press: () {},
          ),
          */
          DrawerListTile(
            title: "Documents",
            icon: CupertinoIcons.doc_person,
            press: () {},
          ),
          /*DrawerListTile(
            title: "Store",
            svgsrc: "assets/icons/task.svg",
            press: () {},
          ),*/
          DrawerListTile(
            title: "Notification",
            icon: FeatherIcons.activity, //"assets/icons/menu_notification.svg",
            press: () {},
          ),
          DrawerListTile(
            title: "Profile",
            icon: CupertinoIcons.person_fill,
            press: () {},
          ),
          DrawerListTile(
            title: "Settings",
            icon: CupertinoIcons.settings,
            press: () {},
          ),
        ],
      ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    icon = Icons.error,
    required this.press,
  })  : _icon = icon,
        super(key: key);

  //final String? svgSrc;
  final String title;
  IconData? _icon;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    //ColorFilter.mode(Colors.white54, BlendMode.srcIn)
    return ListTile(
      onTap: press,
      selectedColor: Theme.of(context).primaryColorDark,
      horizontalTitleGap: 0.0,
      leading: Icon(
        size: 26,
        _icon,
        color:
            Color.fromARGB(255, 90, 44, 80), //Color.fromARGB(255, 16, 81, 86),
      ),
      //   : SvgPicture.asset(
      //     svgSrc!,
      //   colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
      // height: 16,
      //),
      title: Text(
        title,
        style: TextStyle(color: Color.fromARGB(255, 252, 252, 253)),
      ),
    );
  }
}
