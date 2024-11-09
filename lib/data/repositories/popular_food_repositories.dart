import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ui_project/data/models/Home/food_model.dart';

class PopularFoodRepositories {
    CollectionReference collectFoods =
        FirebaseFirestore.instance.collection('Food');

  Future<List<FoodModel>> getPopularFoods() async {
  
    await Future.delayed(const Duration(seconds: 2));

    QuerySnapshot snapshot =
        await collectFoods.where('isHot', isEqualTo: 1).get();

    return snapshot.docs.map((doc) {
      return FoodModel.fromJson(doc.data() as Map<String, dynamic>);
    }).toList();
  }

  Future<List<FoodModel>> getListFood() async {
    QuerySnapshot snapshot = await collectFoods.get();

    return snapshot.docs.map((doc) {
      return FoodModel.fromJson((doc.data() as Map<String, dynamic>));
    }).toList();
  }
}
