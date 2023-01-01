import 'package:flutter/material.dart';
import 'package:my_health_assistant/src/controllers/chat_controller/chat_controller.dart';
import 'package:my_health_assistant/src/models/chat_model/chat.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/views/patient/screens/history/widgets/conversation.dart';
import 'package:my_health_assistant/src/widgets/custom_appbar/custom_appbar.dart';

import 'build_chat.dart';

class ChatRoom extends StatefulWidget {
  const ChatRoom({Key? key, required this.doctorId, required this.doctorName})
      : super(key: key);

  @override
  State<ChatRoom> createState() => _ChatRoomState();
  final String doctorId;
  final String doctorName;
  // final Doctor doctor;
}

class _ChatRoomState extends State<ChatRoom> {
  final ScrollController scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: widget.doctorName,
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
            List<ConversationModel> conversations = snapshot.data!;
            return Column(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                    ),
                    child: ClipRRect(
                      child: Conversation(
                        existedConversation: ChatController.getConversationByCon(
                            conversations, widget.doctorId),
                        scrollController: scrollController,
                      ),
                    ),
                  ),
                ),
                BuildChat(
                  existedConversation: ChatController.getConversationByCon(
                      conversations, widget.doctorId),
                  doctorId: widget.doctorId,
                  scrollController: scrollController,
                ),
              ],
            );
          }
          return Container();
        }),
      ),
    );
  }
}
