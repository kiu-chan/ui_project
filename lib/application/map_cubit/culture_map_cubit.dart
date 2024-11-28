import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/data/models/Home/culture_model.dart';

class CultureMapCubit extends Cubit<List<CultureModel>> {
  CultureMapCubit() : super([]);

  CollectionReference collection =
      FirebaseFirestore.instance.collection('Culture');

  Future<void> getPosition() async {
    try {
      final QuerySnapshot snapshot = await collection.get();
      final locations = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return CultureModel.fromJson(data);
      }).toList();

      emit(locations);
    } catch (e) {
      print(e.toString());
    }
  }
}
