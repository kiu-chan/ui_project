import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/Users/users_model.dart';

class UsersRepositories {
  CollectionReference collectDestinations =
      FirebaseFirestore.instance.collection('users');

Future<UsersModel?> getUserByUserId(int userId) async {
  QuerySnapshot snapshot = await collectDestinations
      .where('userId', isEqualTo: userId)
      .limit(1)
      .get();

  if (snapshot.docs.isNotEmpty) {
    return UsersModel.fromJson(snapshot.docs.first.data() as Map<String, dynamic>);
  }
  return null; 
}
}
