import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/NewsFeed/news_feed_model.dart';

class NewsFeedRepositories {
  CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('posts');

  Future<List<NewsFeedModel>> getData() async {
    await Future.delayed(const Duration(milliseconds: 2));

    QuerySnapshot snapshot = await collectDestinations.get();

    return snapshot.docs.map((doc) {
      return NewsFeedModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

}

