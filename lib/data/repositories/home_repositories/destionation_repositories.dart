import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';

class PopularDestionationRepositories {
  CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('Destinations');

  // Popular Destinatons
  Future<List<DestinationsModels>> getPopularDestionations() async {
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectDestinations.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return DestinationsModels.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  // All Destinations
  Future<List<DestinationsModels>> getListDestinations() async {
    await Future.delayed(const Duration(milliseconds: 2));

    QuerySnapshot snapshot = await collectDestinations.get();

    return snapshot.docs.map((doc) {
      return DestinationsModels.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<DestinationsModels>> SearchDestinationsByTitle(
      String query) async {
    QuerySnapshot snapshot = await collectDestinations
        .where('title', isGreaterThanOrEqualTo: query.toLowerCase())
        .where('title', isLessThanOrEqualTo: query.toLowerCase() + '\uf8ff')
        .get();
    print('Searching for: $query, lowercased: ${query.toLowerCase()}');

    return snapshot.docs.map((doc) {
      return DestinationsModels.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
