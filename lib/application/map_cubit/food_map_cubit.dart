import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/data/models/Home/food_model.dart';

class FoodMapCubit extends Cubit<List<FoodModel>> {
  CollectionReference collection = FirebaseFirestore.instance.collection('Food');
  FoodMapCubit() : super([]);

  Future<void> getPosition() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final locations = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return FoodModel.fromJson(data);
      }).toList();

      emit(locations);
    } catch(e) {
      print(e.toString());
    }
  }
}