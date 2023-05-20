import 'package:cloud_firestore/cloud_firestore.dart';

class HomeFirebaseService {
  // Future<void> saveUserPassangerInfo(
  //     String email, String fromWhere, String toWhere) async {
  //   try {
  //     CollectionReference<Map<String, dynamic>> usersCollectionRef =
  //         FirebaseFirestore.instance.collection('userInfo');

  //     usersCollectionRef
  //         .where("email", isEqualTo: email)
  //         .get()
  //         .then((userInfoValue) async {
  //       for (var result in userInfoValue.docs) {
  //         await FirebaseFirestore.instance
  //             .collection('userInfo')
  //             .doc(result.id)
  //             .collection("passenger")
  //             .doc()
  //             .set(
  //           {
  //             "fromWhere": fromWhere,
  //             "toWhere": toWhere,
  //           },
  //         );
  //       }
  //     });
  //   } catch (e) {
  //     throw e.toString();
  //   }
  // }
}
