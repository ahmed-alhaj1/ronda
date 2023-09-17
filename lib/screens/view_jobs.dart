import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:like_button/like_button.dart';
import 'package:ronda/models/post.dart';
import 'package:ronda/models/user.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:ronda/widgets/indicators.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:cloud_firestore/cloud_firestore.dart';

class ViewJob extends StatefulWidget {
  final PostModel? post;

  ViewJob({this.post});

  @override
  _ViewJobState createState() => _ViewJobState();
}

final DateTime timestamp = DateTime.now();

currentUserId() {
  return firebaseAuth.currentUser!.uid;
}

UserModel? user;

class _ViewJobState extends State<ViewJob> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.all(30.0),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff4D4D4D),
                borderRadius: BorderRadius.circular(20),
                //border: Border.all(
                //  color: const Color.fromARGB(223, 173, 171, 177),
                //width: 1)
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xff4D4D4D),
                    Color.fromARGB(255, 114, 143, 156),
                  ],
                  stops: [0.1507, 1.044],
                ),
              ),
              height: 300,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
              child: widget.post!.description != null
                  ? Text(widget.post!.description!)
                  : const Text(''),
            ),
          ),
          SizedBox(height: 30),
          Padding(
            padding: EdgeInsets.all(30),
            child: Container(
              /*
               gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Color(0xff597FDB),
                      ],
              */
              decoration: BoxDecoration(
                color: Color(0xff4D4D4D),
                borderRadius: BorderRadius.circular(20),
                //border: Border.all(
                //   color: Color.fromARGB(223, 173, 171, 177), width: 1),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xff4D4D4D),
                    Color.fromARGB(255, 114, 143, 156),
                  ],
                  stops: [0.1507, 1.044],
                ),
              ),
              height: 100,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
              child: Row(
                children: [
                  const Column(
                    children: [
                      Text(
                        "\$50.00",
                        style: TextStyle(
                          fontSize: 16.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text('Fixed price'),
                    ],
                  ),
                  SizedBox(
                      width: (MediaQuery.of(context).size.width / 2) - 200),
                  const Column(children: [
                    Text('Entry level',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    Text('Experience Level')
                  ]),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              top: 50,
              left: 30,
              right: 30,
              bottom: 25,
            ),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff4D4D4D),
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: <Color>[
                    Color(0xff4D4D4D),
                    Color.fromARGB(255, 114, 143, 156),
                  ],
                  stops: [0.1507, 1.044],
                ),
                // border: Border.all(
                //   color: const Color.fromARGB(223, 173, 171, 177),
                // width: 1)
              ),
              height: 70,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 24),
              child: const Row(children: [
                Text(
                  'Flutter',
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'Firebase',
                  overflow: TextOverflow.clip,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'web design',
                  overflow: TextOverflow.ellipsis,
                )
              ]),
            ),
          )
        ],
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  //Navigator.of(context).pushReplacement(
                  //CupertinoPageRoute(
                  //builder: (_) => Login(),
                  //),
                  //);
                },
                child: Container(
                  height: 45.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(color: Colors.grey),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Color.fromARGB(255, 89, 219, 95),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Save job',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              GestureDetector(
                onTap: () {
                  //Navigator.of(context).pushReplacement(
                  //  CupertinoPageRoute(
                  //    builder: (_) => ,
                  //  ),
                  //);
                },
                child: Container(
                  height: 45.0,
                  width: 130.0,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40.0),
                    border: Border.all(color: Colors.white),
                    gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      colors: [
                        Theme.of(context).colorScheme.secondary,
                        Color.fromARGB(255, 89, 219, 95),
                      ],
                    ),
                  ),
                  child: const Center(
                    child: Text(
                      'Submit proposal',
                      style: TextStyle(
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),

      /*bottomNavigationBar: BottomAppBar(
        elevation: 0.0,
        color: Colors.transparent,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            child: Row(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.post!.username!,
                      style: const TextStyle(fontWeight: FontWeight.w800),
                    ),
                    SizedBox(height: 3.0),
                    Row(
                      children: [
                        Icon(Ionicons.alarm_outline, size: 13.0),
                        SizedBox(width: 3.0),
                        Text(
                          timeago.format(widget.post!.timestamp!.toDate()),
                        ),
                      ],
                    ),
                  ],
                ),
                Spacer(),
                buildLikeButton(),
              ],
            ),
          ),
        ),
      ),*/
    );
  }

  buildImage(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0),
      child: Container(
        //borderRadius: BorderRadius.circular(5.0),
        child: Text('Flutter developer ',
            maxLines: 6,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
                fontSize: 12,
                color: Color(0xdddddd),
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  addLikesToNotification() async {
    bool isNotMe = currentUserId() != widget.post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(widget.post!.ownerId)
          .collection('notifications')
          .doc(widget.post!.postId)
          .set({
        "type": "like",
        "username": user!.username!,
        "userId": currentUserId(),
        "userDp": user!.photoUrl,
        "postId": widget.post!.postId,
        "mediaUrl": widget.post!.mediaUrl,
        "timestamp": timestamp,
      });
    }
  }

  removeLikeFromNotification() async {
    bool isNotMe = currentUserId() != widget.post!.ownerId;

    if (isNotMe) {
      DocumentSnapshot doc = await usersRef.doc(currentUserId()).get();
      user = UserModel.fromJson(doc.data() as Map<String, dynamic>);
      notificationRef
          .doc(widget.post!.ownerId)
          .collection('notifications')
          .doc(widget.post!.postId)
          .get()
          .then((doc) => {
                if (doc.exists) {doc.reference.delete()}
              });
    }
  }

  buildLikeButton() {
    return StreamBuilder(
      stream: likesRef
          .where('postId', isEqualTo: widget.post!.postId)
          .where('userId', isEqualTo: currentUserId())
          .snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasData) {
          List<QueryDocumentSnapshot> docs = snapshot.data?.docs ?? [];
          // return IconButton(
          //   onPressed: () {
          //     if (docs.isEmpty) {
          //       likesRef.add({
          //         'userId': currentUserId(),
          //         'postId': widget.post!.postId,
          //         'dateCreated': Timestamp.now(),
          //       });
          //       addLikesToNotification();
          //     } else {
          //       likesRef.doc(docs[0].id).delete();
          //       removeLikeFromNotification();
          //     }
          //   },
          //   icon: docs.isEmpty
          //       ? Icon(
          //           CupertinoIcons.heart,
          //         )
          //       : Icon(
          //           CupertinoIcons.heart_fill,
          //           color: Colors.red,
          //         ),
          // );
          ///added animated like button
          Future<bool> onLikeButtonTapped(bool isLiked) async {
            if (docs.isEmpty) {
              likesRef.add({
                'userId': currentUserId(),
                'postId': widget.post!.postId,
                'dateCreated': Timestamp.now(),
              });
              addLikesToNotification();
              return !isLiked;
            } else {
              likesRef.doc(docs[0].id).delete();
              removeLikeFromNotification();
              return isLiked;
            }
          }

          return LikeButton(
            onTap: onLikeButtonTapped,
            size: 25.0,
            circleColor: const CircleColor(
                start: Color(0xffFFC0CB), end: Color(0xffff0000)),
            bubblesColor: const BubblesColor(
              dotPrimaryColor: Color(0xffFFA500),
              dotSecondaryColor: Color(0xffd8392b),
              dotThirdColor: Color(0xffFF69B4),
              dotLastColor: Color(0xffff8c00),
            ),
            likeBuilder: (bool isLiked) {
              return Icon(
                docs.isEmpty ? Ionicons.heart_outline : Ionicons.heart,
                color: docs.isEmpty ? Colors.grey : Colors.red,
                size: 25,
              );
            },
          );
        }
        return Container();
      },
    );
  }
}
