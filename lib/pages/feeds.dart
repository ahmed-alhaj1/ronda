import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:ionicons/ionicons.dart';
import 'package:ronda/chats/recent_chats.dart';
import 'package:ronda/models/post.dart';
import 'package:ronda/pages/profile.dart';
import 'package:ronda/utils/constants.dart';
import 'package:ronda/utils/firebase.dart';
import 'package:ronda/widgets/indicators.dart';
import 'package:ronda/widgets/story_widget.dart';
//import 'package:ronda/widgets/userpost.dart';
import 'package:ronda/widgets/jobpost.dart';
import 'package:ronda/components/profile_card.dart';
import 'package:ronda/utils/responsive.dart';

class Feeds extends StatefulWidget {
  @override
  _FeedsState createState() => _FeedsState();
}

class _FeedsState extends State<Feeds> with AutomaticKeepAliveClientMixin {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  int page = 5;
  bool loadingMore = false;
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(() async {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        setState(() {
          page = page + 5;
          loadingMore = true;
        });
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    print('>>>');
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: scaffoldKey,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          Constants.appName,
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              Ionicons.chatbubble_ellipses,
              size: 30.0,
            ),
            onPressed: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (_) => Chats(),
                ),
              );
            },
          ),
          SizedBox(width: 20.0),
        ],
      ),
      body: RefreshIndicator(
        color: Theme.of(context).colorScheme.secondary,
        onRefresh: () =>
            postRef.orderBy('timestamp', descending: true).limit(page).get(),
        child: Row(
          children: [
            //if (!Responsive.isMobile(context)) SizedBox(height: defaultPadding),
            //if (!Responsive.isMobile(context)) ProfileCard(),

            Flexible(
              flex: 4,
              child: SingleChildScrollView(
                // controller: scrollController,
                physics: NeverScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      //if (Respo
                      //const StoryWidget(),

                      //const SizedBox(height: 5),
                      const StoryWidget(),
                      //SizedBox(
                      //  height: 10,
                      //),
                      if (Responsive.isMobile(context))
                        Container(
                            //verticalDirection:
                            //constraints: const BoxConstraints(minHeight: 60),
                            alignment: Alignment.topCenter,
                            height: 190,
                            //padding: const EdgeInsets.symmetric(
                            //  horizontal: 3.0, vertical: 5.0),
                            child: ProfileCard()),

                      const SizedBox(height: defaultPadding),

                      Container(
                        height: Responsive.isMobile(context)
                            ? MediaQuery.of(context).size.height - 480
                            : MediaQuery.of(context).size.height,
                        child: FutureBuilder(
                          future: postRef
                              .orderBy('timestamp', descending: true)
                              .limit(page)
                              .get(),
                          builder:
                              (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasData) {
                              var snap = snapshot.data;
                              List docs = snap!.docs;
                              return ListView.builder(
                                controller: scrollController,
                                itemCount: docs.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index) {
                                  PostModel posts =
                                      PostModel.fromJson(docs[index].data());
                                  return Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: JobPost(post: posts),
                                  );
                                },
                              );
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return circularProgress(context);
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
                      ),
                      //Expanded(child: ProfileCard()),
                    ],
                  ),
                ),
              ),
            ),

            if (Responsive.isDesktop(context))
              Expanded(flex: 1, child: ProfileCard())
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
