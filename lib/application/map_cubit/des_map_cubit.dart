import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_project/data/models/Home/destinations_model.dart';

class MapDesCubit extends Cubit<List<DestinationsModels>> {
  CollectionReference collection =
      FirebaseFirestore.instance.collection('Destinations');
  MapDesCubit() : super([]);

  Future<void> getPosition() async {
    try {
      QuerySnapshot snapshot = await collection.get();

      final locations = snapshot.docs.map((doc) {
        final data = doc.data() as Map<String, dynamic>;
        return DestinationsModels.fromJson(data);
      }).toList();

      emit(locations);
    } catch (e) {
      print(e.toString());
    }
  }
}


