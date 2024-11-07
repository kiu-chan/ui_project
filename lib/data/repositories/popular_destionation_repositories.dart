import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';

class PopularDestionationRepositories {
  Future<List<DestinationsModels>> getPopularDestionations() async {
    CollectionReference collectDestinations =
        FirebaseFirestore.instance.collection('Destinations');
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectDestinations.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return DestinationsModels.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
