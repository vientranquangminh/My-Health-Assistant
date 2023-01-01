import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/models/chat_model/chat.dart';
import 'package:my_health_assistant/src/views/global_var.dart';

class ChatController {
  static var logger = Logger();
  static final db = FirebaseFirestore.instance;
  static void addMessage(Map<String, dynamic> json, String id) {
    db.collection('conversations').doc(id).set(json);
  }

  static Stream<List<ConversationModel>> getAllConversation() {
    return FirebaseFirestore.instance
        .collection('conversations')
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ConversationModel.fromJson(doc.data()))
            .toList());
  }

  static ConversationModel? getConversationByCon(
      List<ConversationModel> allConversation, String condition) {
    for (var element in allConversation) {
      if (element.conversationId == '${auth.currentUser?.uid}$condition') {
        return element;
      }
    }
    return null;
  }

  static List<ConversationModel> getActiveConversation(
      List<ConversationModel> allConversation) {
    List<ConversationModel> conversationList = [];
    for (var element in allConversation) {
      if (element.isActive == true) {
        conversationList.add(element);
      }
    }
    return conversationList;
  }

  static List<ConversationModel> getPatientConversation(
      List<ConversationModel> getAllConversation) {
    List<ConversationModel> conversationList = [];
    for (var element in getAllConversation) {
      if (element.patientId == auth.currentUser?.uid) {
        Logger().i('auth uid patient: ${auth.currentUser?.uid}');
        conversationList.add(element);
      }
    }
    return conversationList;
  }

  // for doctor
  static List<ConversationModel> getDoctorConversation(
      List<ConversationModel> getAllConversation) {
    List<ConversationModel> conversationList = [];
    for (var element in getAllConversation) {
      if (element.doctorId == auth.currentUser?.uid &&
          element.lastMessage != null) {
        Logger().i('auth uid doctor: ${auth.currentUser?.uid}');
        conversationList.add(element);
      }
    }
    return conversationList;
  }

  static ConversationModel? getConversationById(
      List<ConversationModel> getAllConversation, String conversationId) {
    for (var element in getAllConversation) {
      if (element.conversationId == conversationId) {
        Logger().i('auth uid doctor: ${auth.currentUser?.uid}');
        return element;
      }
    }
    return null;
  }
}
