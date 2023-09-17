import 'package:flutter/material.dart';
import 'package:ronda/utils/constants.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:firebase_auth/firebase_auth.dart';
import 'package:ronda/models/user.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:ionicons/ionicons.dart';
import 'package:flutter/cupertino.dart';
import 'package:ronda/screens/settings.dart';

class ProfileCard extends StatelessWidget {
  //final profileId;

  ProfileCard({Key? key}) : super(key: key);

  currentUserId() {
    return firebaseAuth.currentUser?.uid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: MediaQuery.of(context).size.width * 0.4,

      padding: const EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        //color: Theme.of(context).primaryColorDark,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: StreamBuilder(
        stream: usersRef.doc(currentUserId()).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            print('!!!!!!!!!!!! going to quired user data !!!!!!!!!!!!! ');
            UserModel user = UserModel.fromJson(
              snapshot.data!.data() as Map<String, dynamic>,
            );
            print('user user.username : ${user.username}');
            return Container(
              padding: const EdgeInsets.all(16.0),
              decoration: const BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.start,
                //shrinkWrap: true,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10.0),
                      topRight: Radius.circular(10.0),
                    ),
                    child: user.photoUrl!.isEmpty
                        ? CircleAvatar(
                            radius: 40.0,
                            backgroundColor:
                                Theme.of(context).colorScheme.secondary,
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
                        : CircleAvatar(
                            radius: 40.0,
                            backgroundImage:
                                CachedNetworkImageProvider(user.photoUrl!),
                          ),
                  ),
                  const SizedBox(width: 20.0),

                  Flexible(
                    child: Text(
                      user.username!,
                      style: const TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.w900,
                      ),
                      maxLines: null,
                    ),
                  ),
                  Flexible(
                    //width: 130.0,
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
                  SizedBox(width: 10.0),
                  Flexible(
                    child: Text(
                      user.email!,
                      style: const TextStyle(
                        fontSize: 10.0,
                      ),
                    ),
                    //],
                  ),

                  InkWell(
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
                          color: Theme.of(context).indicatorColor,
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

                  //: buildLikeButton()
                  // ],
                  //),

                  /*
                      ],
                    ),*/
                  // ],
                  // ),
                ],
              ),
            );
          }
          return Text(' was not able to query data ');
        },
      ),
    );
  }
}
