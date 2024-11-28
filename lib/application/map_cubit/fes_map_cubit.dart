import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/data/models/Home/festival_model.dart';

class FesMapCubit extends Cubit<List<FestivalModel>> {
  FesMapCubit() : super([]);

  CollectionReference collection = FirebaseFirestore.instance.collection('Festivals');

  Future<void> getPosition() async{
    try {
      final QuerySnapshot snapshot = await collection.get();

      final locations = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return FestivalModel.fromJson(data);
      }).toList();

      emit(locations);
    } catch(e) {
      print(e.toString());
    }
  }
}