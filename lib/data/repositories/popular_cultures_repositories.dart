import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/culture_model.dart';

class PopularCultureRepositories {
  CollectionReference collectCultures =
      FirebaseFirestore.instance.collection('Culture');

  
  Future<List<CultureModel>> getPopularCultures() async {
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectCultures.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return CultureModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<CultureModel>> getListCulture() async {
    await Future.delayed(const Duration(milliseconds: 2));

    QuerySnapshot snapshot = await collectCultures.get();

    return snapshot.docs.map((doc) {
      return CultureModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
