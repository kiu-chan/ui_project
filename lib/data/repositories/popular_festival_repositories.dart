import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/festival_model.dart';

class PopularFestivalRepositories {
  CollectionReference collectFestivals =
      FirebaseFirestore.instance.collection('Festivals');

  // Popular Festivals
  Future<List<FestivalModel>> getPopularFestivals() async {
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectFestivals.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return FestivalModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // List All Festivals
  Future<List<FestivalModel>> getListFestival() async {
    await Future.delayed(const Duration(milliseconds: 2));

    QuerySnapshot snapshot = await collectFestivals.get();

    return snapshot.docs.map((doc) {
      return FestivalModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
