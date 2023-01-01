import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_health_assistant/src/controllers/chat_controller/chat_controller.dart';
import 'package:my_health_assistant/src/models/chat_model/chat.dart';
import 'package:my_health_assistant/src/views/doctor/chat/widgets/input_message.dart';
import 'package:my_health_assistant/src/views/global_var.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';
import 'package:timeago/timeago.dart' as timeago;

class RoomChatDoctorScreen extends StatefulWidget {
  const RoomChatDoctorScreen(
      {Key? key, required this.conversationModel, required this.patientName})
      : super(key: key);

  @override
  State<RoomChatDoctorScreen> createState() => _RoomChatDoctorScreenState();
  // final User user;
  final ConversationModel conversationModel;
  final String patientName;
}

class _RoomChatDoctorScreenState extends State<RoomChatDoctorScreen> {
  @override
  Widget build(BuildContext context) {
    // List<Message> message = widget.conversationModel.messages ?? [];
    final ScrollController scrollController = ScrollController();
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.patientName,
        actions: const [
          'assets/images/schedule_page/search.svg',
          'assets/images/schedule_page/more.svg',
        ],
      ),
      backgroundColor: MyColors.mainColor,
      body: StreamBuilder<List<ConversationModel>>(
        stream: ChatController.getAllConversation(),
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
            ConversationModel? conversationModel =
                ChatController.getConversationById(snapshot.data ?? [],
                    widget.conversationModel.conversationId ?? '');
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                        child: ListView.builder(
                            padding: const EdgeInsets.only(bottom: 70),
                            controller: scrollController,
                            itemCount: conversationModel?.messages?.length,
                            itemBuilder: (context, int index) {
                              // final message = message[index];
                              bool isMe = conversationModel
                                      ?.messages?[index].senderId ==
                                  auth.currentUser?.uid;
                              return Container(
                                margin: const EdgeInsets.only(top: 10).r,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: isMe
                                          ? MainAxisAlignment.end
                                          : MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.end,
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.all(10),
                                          constraints: BoxConstraints(
                                              maxWidth: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.6),
                                          decoration: BoxDecoration(
                                              color: isMe
                                                  ? Colors.blue
                                                  : Colors.grey[200],
                                              borderRadius: BorderRadius.only(
                                                topLeft: Radius.circular(
                                                    isMe ? 16 : 3),
                                                topRight:
                                                    const Radius.circular(16),
                                                bottomLeft:
                                                    const Radius.circular(12),
                                                bottomRight: Radius.circular(
                                                    isMe ? 3 : 12),
                                              )),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.end,
                                            children: [
                                              Text(
                                                conversationModel
                                                        ?.messages?[index]
                                                        .content ??
                                                    '',
                                                style: MyFontStyles.blackColorH3
                                                    .copyWith(
                                                        color: isMe
                                                            ? Colors.white
                                                            : Colors.grey[800]),
                                              ),
                                              SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.6 /
                                                    2,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.end,
                                                  children: [
                                                    if (isMe)
                                                      Icon(
                                                        Icons.done_all,
                                                        size: 16.sp,
                                                        color:
                                                            MyColors.whiteText,
                                                      ),
                                                    SizedBox(
                                                      width: 8.w,
                                                    ),
                                                    Text(
                                                      timeago.format(DateTime
                                                          .parse(conversationModel
                                                                  ?.messages?[
                                                                      index]
                                                                  .dateTime ??
                                                              '')),
                                                      style: isMe
                                                          ? MyFontStyles
                                                              .normalWhiteText
                                                          : MyFontStyles
                                                              .normalGreyText,
                                                    )
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              );
                            })),
                  ),
                ),
                InputMessage(
                  conversationModel: conversationModel,
                  scrollController: scrollController,
                )
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
