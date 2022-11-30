import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_health_assistant/src/models/chat_model/message_mock.dart';
import 'package:my_health_assistant/src/models/chat_model/user_model.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class Conversation extends StatelessWidget {
  const Conversation({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(428, 882),
      builder: (context, child) {
        return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (context, int index) {
              final message = messages[index];
              bool isMe = message.sender.id == currentUser.id;
              return Container(
                margin: const EdgeInsets.only(top: 10).r,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: isMe
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          constraints: BoxConstraints(
                              maxWidth:
                                  MediaQuery.of(context).size.width * 0.6),
                          decoration: BoxDecoration(
                              color: isMe ? Colors.blue : Colors.grey[200],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(isMe ? 16 : 3),
                                topRight: const Radius.circular(16),
                                bottomLeft: const Radius.circular(12),
                                bottomRight: Radius.circular(isMe ? 3 : 12),
                              )),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                messages[index].text,
                                style: MyFontStyles.blackColorH3.copyWith(
                                    color:
                                        isMe ? Colors.white : Colors.grey[800]),
                              ),
                              SizedBox(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    if (isMe)
                                      Icon(
                                        Icons.done_all,
                                        size: 16.sp,
                                        color: MyColors.whiteText,
                                      ),
                                    SizedBox(
                                      width: 8.w,
                                    ),
                                    Text(
                                      message.time,
                                      style: isMe
                                          ? MyFontStyles.normalWhiteText
                                          : MyFontStyles.normalGreyText,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(top: 5),
                    //   child:
                    // )
                  ],
                ),
              );
            });
      },
    );
  }
}
