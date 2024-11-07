import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/culture_model.dart';

class PopularCultureRepositories {
  Future<List<CultureModel>> getPopularCultures() async {
    CollectionReference collectCultures =
        FirebaseFirestore.instance.collection('Culture');
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectCultures.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return CultureModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
