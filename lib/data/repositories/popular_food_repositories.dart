import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/food_model.dart';

class PopularFoodRepositories {
  Future<List<FoodModel>> getPopularFoods() async {
    CollectionReference collectFoods =
        FirebaseFirestore.instance.collection('Food');
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectFoods.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return FoodModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }
}
