//import 'dart:ffi';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ronda/auth/register/register.dart';
import 'package:ronda/components/stream_grid_wrapper.dart';
import 'package:ronda/models/post.dart';
import 'package:ronda/models/user.dart';
import 'package:ronda/screens/edit_profile.dart';
import 'package:ronda/screens/list_post.dart';
import 'package:ronda/screens/settings.dart';
import 'package:ronda/utils/firebase.dart';
//import 'package:ronda/widgets/post_tiles.dart';

class Portfolio extends StatefulWidget {
  final portfolioId;
  Portfolio({this.portfolioId});

  @override
  _PortfolioState createState() => _PortfolioState();
}

class _PortfolioState extends State<Portfolio> {
  User? user;
  bool isLoading = false;
  UserModel? users;
  ScrollController scontroller = ScrollController();

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  void initState() {}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Ronda'),
          actions: [
            widget.portfolioId == firebaseAuth.currentUser!.uid
                ? Center(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25.0),
                      child: GestureDetector(
                        onTap: () async {
                          await firebaseAuth.signOut();
                          Navigator.of(context).push(
                            CupertinoPageRoute(
                              builder: (_) => Register(),
                            ),
                          );
                        },
                        child: const Text(
                          'Log Out',
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 15.0,
                          ),
                        ),
                      ),
                    ),
                  )
                : const Center(
                    child: Text(
                        'widget.profileID != firebase.currentUser : pages/profile')),
          ],
        ),
        body: ListView(
          children: [
            /* slivers: <Widget>[
            SliverAppBar(
              automaticallyImplyLeading: false,
              pinned: true,
              floating: false,
              toolbarHeight: 5.0,
              collapsedHeight: 5.0,
              expandedHeight: 225.0,
              flexibleSpace: FlexibleSpaceBar(
                  background: StreamBuilder(
                stream: usersRef.doc(widget.portfolioId).snapshots(),
                builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasData) {
                    print('I at snashot and has data potofolio');
                    UserModel user = UserModel.fromJson(
                      snapshot.data!.data() as Map<String, dynamic>,
                    );

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(left: 20.0),
                                child: CircleAvatar(
                                  radius: 40.0,
                                  backgroundColor:
                                      Theme.of(context).colorScheme.secondary,
                                  backgroundImage: CachedNetworkImageProvider(
                                      user.photoUrl![0]),
                                  child: Center(
                                    child: Text(
                                      '${user.username![0].toUpperCase()}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 15.0,
                                        fontWeight: FontWeight.w900,
                                      ),
                                    ),
                                  ),
                                )
                                //CircleAvatar(
                                // radius: 40.0,
                                //backgroundImage:
                                // CachedNetworkImageProvider(
                                //   user.photoUrl![0]),
                                // )
                                ),
                            SizedBox(width: 20.0),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(height: 32.0),
                                Row(
                                  children: [
                                    const Visibility(
                                      visible: false,
                                      child: SizedBox(width: 10.0),
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          width: 130.0,
                                          child: Text(
                                            user.username!,
                                            style: const TextStyle(
                                              fontSize: 15.0,
                                              fontWeight: FontWeight.w900,
                                            ),
                                            maxLines: null,
                                          ),
                                        ),
                                        Container(
                                          width: 130.0,
                                          child: Text(
                                            user.country!,
                                            style: const TextStyle(
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.w600,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        const SizedBox(width: 10.0),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              user.email!,
                                              style: const TextStyle(
                                                fontSize: 10.0,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                    widget.portfolioId == currentUserId()
                                        ? InkWell(
                                            onTap: () {
                                              Navigator.of(context).push(
                                                CupertinoPageRoute(
                                                  builder: (_) => Setting(),
                                                ),
                                              );
                                            },
                                            child: Column(
                                              children: [
                                                Icon(
                                                  Ionicons.settings_outline,
                                                  color: Theme.of(context)
                                                      .colorScheme
                                                      .secondary,
                                                ),
                                                const Text(
                                                  'settings',
                                                  style: TextStyle(
                                                    fontSize: 11.5,
                                                  ),
                                                )
                                              ],
                                            ),
                                          )
                                        : const Text('')
                                    //: buildLikeButton()
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    );
                  }
                  return Container(child: Text('no profile data'));
                },
              )),
            ),
            const SizedBox(height: 10.0),
            ],*/
            Container(
              //delegate: SliverChildListDelegate(
              //[
              // alignment: AlignmentGeometry,
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 148, 139, 139), width: 4),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  new BoxShadow(
                    color: Color.fromARGB(255, 199, 221, 199),
                    offset: new Offset(6.0, 6.0),
                  ),
                ],
              ),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Center(child: Text('Employee Information ')),
                    SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('name : Ahmed Alhaj', textAlign: TextAlign.start),
                        SizedBox(
                          width: 20.0,
                        ),
                        Text('email : alhaj1@umbc.edu',
                            textAlign: TextAlign.start)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('phone number: 401-900-7372',
                            textAlign: TextAlign.start),
                        SizedBox(width: 20.0),
                        Text('title: project manager ',
                            textAlign: TextAlign.start)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text('occuaption : designer',
                            textAlign: TextAlign.start),
                        SizedBox(width: 20.0),
                        Text('web address : http://yana.com',
                            textAlign: TextAlign.start),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'hire date 12/16/2014',
                          textAlign: TextAlign.start,
                        ),
                        SizedBox(width: 20.0),
                        Text('location: arbutus maryland',
                            textAlign: TextAlign.start),
                      ],
                    )
                  ]),

              // (BuildContext context, int index) {}),
            ),
            SizedBox(
              height: 40,
            ),
            Container(
              padding: EdgeInsets.all(20),
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(
                    color: Color.fromARGB(255, 148, 139, 139), width: 4),
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  new BoxShadow(
                    color: Color.fromARGB(255, 199, 221, 199),
                    offset: new Offset(6.0, 6.0),
                  ),
                ],
              ),
              child: Column(),
            )
          ],
        ));
  }
}

class EmployeeCard extends StatelessWidget {
  final Widget? child;
  final Function() onTap;
  final BorderRadius? borderRadius;
  final bool elevated;

  EmployeeCard({
    Key? key,
    required this.child,
    required this.onTap,
    this.borderRadius,
    this.elevated = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: elevated
          ? BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            )
          : BoxDecoration(
              borderRadius: borderRadius,
              color: Theme.of(context).cardColor,
            ),
      child: Material(
        type: MaterialType.transparency,
        borderRadius: borderRadius,
        child: InkWell(
          borderRadius: borderRadius,
          onTap: onTap,
          child: child,
        ),
      ),
    );
  }
}
