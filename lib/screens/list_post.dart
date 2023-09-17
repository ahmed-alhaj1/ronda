import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ronda/models/post.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:ronda/widgets/indicators.dart';
import 'package:ronda/widgets/userpost.dart';

class ListPosts extends StatefulWidget {
  final userId;

  final username;

  const ListPosts({Key? key, required this.userId, required this.username})
      : super(key: key);

  @override
  State<ListPosts> createState() => _ListPostsState();
}

class _ListPostsState extends State<ListPosts> {
  @override
  Widget build(BuildContext context) {
    print('userId : ${widget.userId}, username : ${widget.username}');
    return Scaffold(
        appBar: AppBar(
          leading: InkWell(
            onTap: () => Navigator.pop(context),
            child: Icon(Ionicons.chevron_back),
          ),
          title: Column(
            children: [
              Text(
                widget.username.toUpperCase(),
                style: const TextStyle(
                  fontSize: 12.0,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey,
                ),
              ),
              const Text(
                'Posts',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        body: widget.userId != null
            ? Container(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: FutureBuilder(
                  future: postRef
                      .where('ownerId', isEqualTo: widget.userId)
                      .orderBy('timestamp', descending: true)
                      .get(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      if (snapshot.hasError) {
                        return Text('this snapshot has an error');
                      }
                      if (snapshot.connectionState == ConnectionState.done) {
                        var snap = snapshot.data;
                        List docs = snap!.docs;
                        return ListView.builder(
                          itemCount: docs.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            PostModel posts =
                                PostModel.fromJson(docs[index].data());
                            print(posts.description!);

                            return Padding(
                              padding: const EdgeInsets.all(10.0),
                              child: UserPost(post: posts),
                            );
                          },
                        );
                      } else {
                        return circularProgress(context);
                      }
                    } else if (snapshot.connectionState ==
                        ConnectionState.waiting) {
                      return linearProgress(context);
                    } else {
                      return const Center(
                        child: Text(
                          'No Feeds',
                          style: TextStyle(
                            fontSize: 26.0,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      );
                    }
                  },
                ),
              )
            : Text('widget.id : ${widget.userId}')
        //),
        );
  }
}
