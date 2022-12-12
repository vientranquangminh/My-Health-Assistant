import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:my_health_assistant/src/data/firebase_firestore/chat/chat_functions.dart';
import 'package:my_health_assistant/src/models/chat_model/chat.dart';
import 'package:my_health_assistant/src/pages/global_var.dart';
import 'package:my_health_assistant/src/pages/patient/screens/history/widgets/chat_room.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:timeago/timeago.dart' as timeago;

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(390, 884),
      builder: (BuildContext context, Widget? child) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: MyColors.whiteText,
            elevation: 0.0,
            leading: SvgPicture.asset('assets/images/main_icon.svg',
                color: Colors.blue),
            title: const Text(
              "Chats",
              style: TextStyle(color: Colors.black),
            ),
            actions: [
              IconButton(
                  onPressed: () {},
                  icon: SvgPicture.asset(
                      'assets/images/schedule_page/search.svg'),
                  color: Colors.black),
              IconButton(
                  onPressed: () {},
                  icon:
                      SvgPicture.asset('assets/images/schedule_page/more.svg'),
                  color: Colors.black)
            ],
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
            child: StreamBuilder<List<ConversationModel>>(
              stream: ChatFunctions.getAllConversation(),
              builder: ((context, snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong ${snapshot.error}');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (snapshot.hasData) {
                  List<ConversationModel> conversations =
                      ChatFunctions.getPatientConversation(snapshot.data ?? []);
                  conversations.sort((a, b) {
                    DateTime aDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                        .parse('${a.lastTime}');
                    DateTime bDate = DateFormat('yyyy-MM-dd HH:mm:ss')
                        .parse('${b.lastTime}');
                    return bDate.compareTo(aDate);
                  });
                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) {
                            return StreamBuilder<DocumentSnapshot>(
                              stream: FirebaseFirestore.instance
                                  .collection("doctors")
                                  .doc(conversations[index].doctorId)
                                  .snapshots(),
                              builder: ((context, snapshot) {
                                if (snapshot.hasError) {
                                  return const Text('Something went wrong');
                                }
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
                                  return const Text("Loading...",
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20));
                                }
                                return ChatRoom(
                                  doctorId: conversations[index].doctorId ?? '',
                                  doctorName: snapshot.data!.get('fullName'),
                                );
                              }),
                            );
                          }));
                        },
                        child: Container(
                          margin: EdgeInsets.only(top: 24.h),
                          child: Row(
                            children: [
                              const CircleAvatar(
                                radius: 25,
                                backgroundImage: AssetImage(
                                    'assets/images/message_screen/Angel.jpg'),
                              ),
                              SizedBox(width: 20.w),
                              Expanded(
                                flex: 6,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    StreamBuilder<DocumentSnapshot>(
                                      stream: FirebaseFirestore.instance
                                          .collection("doctors")
                                          .doc(conversations[index].doctorId)
                                          .snapshots(),
                                      builder: ((context, snapshot) {
                                        if (snapshot.hasError) {
                                          return const Text(
                                              'Something went wrong');
                                        }
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return const Text("Loading...",
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20));
                                        }
                                        return Text(
                                          snapshot.data!.get('fullName'),
                                          style: MyFontStyles.blackColorH1
                                              .copyWith(
                                                  fontWeight:
                                                      conversations[index]
                                                                  .lastSender !=
                                                              auth.currentUser
                                                                  ?.uid
                                                          ? FontWeight.bold
                                                          : FontWeight.normal),
                                        );
                                      }),
                                    ),
                                    // Text(
                                    //   'conversations[index].sender.name',

                                    // ),
                                    const SizedBox(height: 8),
                                    Text(
                                      conversations[index].lastMessage ?? '',
                                      style: MyFontStyles.normalGreyText
                                          .copyWith(
                                              fontSize: 14.sp,
                                              fontWeight: conversations[index]
                                                          .lastSender !=
                                                      auth.currentUser?.uid
                                                  ? FontWeight.bold
                                                  : FontWeight.normal),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              const Spacer(),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  // Text(
                                  //   'recentChats[index].day!',
                                  //   style: MyFontStyles.normalGreyText
                                  //       .copyWith(fontSize: 14.sp),
                                  // ),
                                  SizedBox(height: 6.h),
                                  Text(
                                    timeago.format(DateTime.parse(
                                        conversations[index].lastTime ?? '')),
                                    style: MyFontStyles.normalGreyText.copyWith(
                                      fontSize: 14.sp,
                                      fontWeight:
                                          conversations[index].lastSender !=
                                                  auth.currentUser?.uid
                                              ? FontWeight.bold
                                              : FontWeight.normal,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                }
                return Container();
              }),
            ),
          ),
        );
      },
    );
  }
}
