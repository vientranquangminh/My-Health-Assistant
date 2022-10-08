import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:my_health_assistant/src/models/chat_model/message_model.dart';
import 'package:my_health_assistant/src/pages/screens/history/widgets/chat_room.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: MyColors.whiteText,
            elevation: 0.0,
            leading: SvgPicture.asset('assets/images/main_icon.svg',
                color: Colors.blue),
            title: const Text(
              "Message",
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
            ]),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16),
          child: ListView.builder(
            itemCount: recentChats.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return ChatRoom(
                      user: recentChats[index].sender,
                    );
                  }));
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage:
                              AssetImage(recentChats[index].avatar!),
                        ),
                        const SizedBox(width: 20),
                        Flexible(
                          flex: 6,
                          child: SizedBox(
                            width: MediaQuery.of(context).size.width,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  overflow: TextOverflow.ellipsis,
                                  recentChats[index].sender.name,
                                  style: MyFontStyles.blackColorH1,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  recentChats[index].text,
                                  overflow: TextOverflow.ellipsis,
                                  style: MyFontStyles.normalGreyText
                                      .copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const Spacer(),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              recentChats[index].day!,
                              style: MyFontStyles.normalGreyText
                                  .copyWith(fontSize: 14),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              recentChats[index].time,
                              style: MyFontStyles.normalGreyText
                                  .copyWith(fontSize: 14),
                            ),
                          ],
                        ),
                      ],
                    )),
              );
            },
          ),
        ));
  }
}
