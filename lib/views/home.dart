import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zchat/models/user_model.dart';
import 'package:zchat/utils/margin.dart';
import 'package:zchat/utils/theme.dart';
import 'package:zchat/view_models/home_vm.dart';
import 'package:zchat/widgets/loader.dart';

class HomePage extends StatefulWidget {
  final UserModel userModel;
  const HomePage(this.userModel);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    var tempProvider = context.read<HomeViewModel>();
    tempProvider.senderModel = widget.userModel;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeViewModel>();
    return Scaffold(
      backgroundColor: altBg,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: context.screenWidth(),
            decoration: BoxDecoration(
              color: white,
              borderRadius: BorderRadius.circular(10),
              boxShadow: [
                BoxShadow(
                    blurRadius: 20,
                    color: grey.withOpacity(0.17),
                    offset: Offset(0, 4))
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const YMargin(50),
                Text(
                  'Žchat',
                  style: GoogleFonts.notoSans(
                    textStyle: TextStyle(
                        color: primary,
                        fontSize: 23,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                const YMargin(25),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.only(top: 30),
              children: [
                StreamBuilder(
                    stream: provider.chatUsersFeed(),
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return  Loader();
                      } else {
                        var items = snapshot.data.documents;
                        if (items.length <= 0)
                          return Container();
                        else
                          return Column(
                            children: [
                              for (var i = 0; i < items.length; i++)
                                UserWidget(items[i], i),
                            ],
                          );
                      }
                    }),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class UserWidget extends StatefulWidget {
  final DocumentSnapshot data;
  final int i;
  const UserWidget(this.data, this.i);

  @override
  _UserWidgetState createState() => _UserWidgetState();
}

class _UserWidgetState extends State<UserWidget> {
  @override
  void initState() {
    setState(() {});
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var provider = context.watch<HomeViewModel>();
    var userModel = UserModel.fromSnapshot(widget.data);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Material(
          color: white,
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  child: CircleAvatar(
                    radius: 30,
                    backgroundImage: NetworkImage(userModel?.profilePicUrl !=
                                null &&
                            userModel.profilePicUrl.isNotEmpty
                        ? userModel.profilePicUrl
                        : 'https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_1280.png'),
                  ),
                ),
                const XMargin(14),
                Container(
                  width: context.screenWidth(percent: 0.4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        userModel?.name ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: textColor),
                      ),
                      const YMargin(6),
                      Text(
                        userModel.email ?? '',
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w300,
                            color: textColor),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                IconButton(
                  onPressed: () {
                    provider.receiverModel = userModel;
                    // context.navigate(ChatScreen(chatId: chatModel.reference.documentID));
                  },
                  icon: Icon(Icons.call),
                ),
                IconButton(
                  onPressed: () {
                    provider.receiverModel = userModel;
                    // context.navigate(ChatScreen(chatId: chatModel.reference.documentID));
                  },
                  icon: Icon(
                    Icons.videocam,
                    color: primary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
