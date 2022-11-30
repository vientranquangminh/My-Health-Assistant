import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_health_assistant/src/models/chat_model/message_mock.dart';
import 'package:my_health_assistant/src/pages/patient/screens/history/widgets/chat_room.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

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
                      icon: SvgPicture.asset(
                          'assets/images/schedule_page/more.svg'),
                      color: Colors.black)
                ]),
            body: Padding(
              padding: EdgeInsets.symmetric(vertical: 8.0.h, horizontal: 16.w),
              child: ListView.builder(
                itemCount: recentChats.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                        return ChatRoom(
                          user: recentChats[index].sender,
                        );
                      }));
                    },
                    child: Container(
                        margin:  EdgeInsets.only(top: 24.h),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 25,
                              backgroundImage:
                                  AssetImage(recentChats[index].avatar!),
                            ),
                            SizedBox(width: 20.w),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  recentChats[index].sender.name,
                                  style: MyFontStyles.blackColorH1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  recentChats[index].text,
                                  style: MyFontStyles.normalGreyText
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                            const Spacer(),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  recentChats[index].day!,
                                  style: MyFontStyles.normalGreyText
                                      .copyWith(fontSize: 14.sp),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  recentChats[index].time,
                                  style: MyFontStyles.normalGreyText
                                      .copyWith(fontSize: 14.sp),
                                ),
                              ],
                            ),
                          ],
                        )),
                  );
                },
              ),
            ));
      },
    );
  }
}
