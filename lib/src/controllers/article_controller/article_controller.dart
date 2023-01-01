import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:logger/logger.dart';
import 'package:my_health_assistant/src/models/article/article.dart';
import 'package:my_health_assistant/src/views/global_var.dart';

class ArticleController {
  static var logger = Logger();
  static final db = FirebaseFirestore.instance;

  static void addArticle(Map<String, dynamic> json, String id) {
    db.collection('articles').doc(id).set(json);
  }

  static Stream<List<Article>> getAllArticles() {
    return FirebaseFirestore.instance.collection('articles').snapshots().map(
        (snapshot) =>
            snapshot.docs.map((doc) => Article.fromJson(doc.data())).toList());
  }

  static List<Article> getArticlesByCon(
      List<Article> allArticles, String category) {
    List<Article> articlesList = [];
    for (var element in allArticles) {
      if (element.category == category &&
          element.doctorID == auth.currentUser!.uid) {
        log('currentUserID: ${auth.currentUser!.uid} - doctorID: ${element.doctorID}');
        articlesList.add(element);
      }
    }
    return articlesList;
  }

  static List<Article> getAllArticlesOfSpecificDoctor(
      List<Article> allArticles) {
    List<Article> articlesList = [];
    for (var element in allArticles) {
      if (element.doctorID == auth.currentUser!.uid) {
        log('currentUserID: ${auth.currentUser!.uid} - doctorID: ${element.doctorID}');
        articlesList.add(element);
      }
    }
    return articlesList;
  }

  static List<Article> getArticlesByCategory(List<Article> allArticles, String category){
    List<Article> articlesList = [];
    for (var element in allArticles) {
      if (element.category == category) {
        articlesList.add(element);
      }
    }
    return articlesList;
  }

  static Stream<List<Article>> getAllArticlesByCondition(String status) {
    if (status == 'All') {
      return FirebaseFirestore.instance.collection('articles').snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => Article.fromJson(doc.data()))
              .toList());
    } else {
      return FirebaseFirestore.instance
          .collection('articles')
          .where('category', isEqualTo: status)
          .snapshots()
          .map((snapshot) => snapshot.docs
              .map((doc) => Article.fromJson(doc.data()))
              .toList());
    }
  }

  static void deleteAllArticlesByStatus(String status) async {
    if (status == 'All') {
      var collection = FirebaseFirestore.instance.collection('articles');
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    } else {
      var collection = FirebaseFirestore.instance
          .collection('articles')
          .where('category', isEqualTo: status);
      var snapshots = await collection.get();
      for (var doc in snapshots.docs) {
        await doc.reference.delete();
      }
    }
  }
}
