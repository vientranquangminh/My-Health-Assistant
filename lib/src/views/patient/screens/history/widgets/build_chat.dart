import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:my_health_assistant/src/models/chat_model/chat.dart';
import 'package:my_health_assistant/src/views/global_var.dart';
import 'package:my_health_assistant/src/views/patient/screens/history/widgets/attach_card.dart';
import 'package:my_health_assistant/src/styles/colors.dart';
import 'package:my_health_assistant/src/styles/font_styles.dart';

class BuildChat extends StatelessWidget {
  const BuildChat(
      {Key? key,
      required this.existedConversation,
      required this.doctorId,
      required this.scrollController})
      : super(key: key);
  final ConversationModel? existedConversation;
  final String doctorId;
  final ScrollController scrollController;
  @override
  Widget build(BuildContext context) {
    TextEditingController messageController = TextEditingController();
    return ScreenUtilInit(
      designSize: const Size(428, 882),
      builder: (context, child) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          color: Colors.white,
          height: 70,
          child: Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  height: 60,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.emoji_emotions_outlined,
                        color: Colors.grey[500],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: null,
                          controller: messageController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Type a message...',
                            hintStyle: MyFontStyles.normalGreyText
                                .copyWith(fontSize: 14),
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            context: context,
                            builder: (context) {
                              return SizedBox(
                                height: 260.h,
                                width: MediaQuery.of(context).size.width,
                                child: Container(
                                  margin: const EdgeInsets.only(
                                          bottom: 90, left: 20, right: 20)
                                      .r,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(30)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(30.0).r,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        AttachCard(
                                            onPressed: () => log('Document'),
                                            color: Colors.orangeAccent,
                                            icon:
                                                'assets/images/message_screen/google-docs_1.svg',
                                            title: 'Document'),
                                        AttachCard(
                                            onPressed: () => log('Gallery'),
                                            color: Colors.greenAccent,
                                            icon:
                                                'assets/images/message_screen/gallery_1.svg',
                                            title: 'Gallery'),
                                        AttachCard(
                                            onPressed: () => log('Audio'),
                                            color: Colors.pinkAccent,
                                            icon:
                                                'assets/images/message_screen/headphone-symbol_1.svg',
                                            title: 'Audio'),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        icon: Icon(
                          Icons.attach_file,
                          color: Colors.grey[500],
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          log('camera');
                        },
                        icon: Icon(
                          Icons.camera_alt_rounded,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                width: 8,
              ),
              CircleAvatar(
                radius: 20,
                backgroundColor: MyColors.mainColor,
                child: IconButton(
                  onPressed: () {
                    scrollController.animateTo(
                        scrollController.position.maxScrollExtent,
                        duration: const Duration(milliseconds: 1),
                        curve: Curves.fastOutSlowIn);
                    log('send');
                    log(messageController.text);
                    // List<Map<String, dynamic>> messages = [
                    Map<String, dynamic> currentMessage = Message(
                            content: messageController.text,
                            dateTime: DateTime.now().toString(),
                            senderId: auth.currentUser?.uid)
                        .toJson();
                    // ];
                    List<Map<String, dynamic>> ls = existedConversation!
                        .messages!
                        .map((e) => e.toJson())
                        .toList();
                    log('ls: $ls');
                    // Message message = Message(content: messageController.text, dateTime: DateTime.now().toString(), senderId: auth.currentUser?.uid);
                    ls.add(currentMessage);
                    ls.reversed;
                    log('id: ${auth.currentUser!.uid}$doctorId');
                    log('conversationID 1: ${auth.currentUser!.uid}bj9yHvKmShbtdNJoBrlYBJPllq82');
                    log('conversationID 2: ${auth.currentUser!.uid}$doctorId');
                    var collection =
                        FirebaseFirestore.instance.collection('conversations');
                    collection.doc('${auth.currentUser!.uid}$doctorId').update({
                      'messages': ls,
                      'isActive': true,
                      'lastMessage': messageController.text,
                      'lastTime': DateTime.now().toString(),
                      'lastSender': auth.currentUser?.uid
                    });
                    messageController.text = '';
                  },
                  icon: const Icon(
                    Icons.send,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
