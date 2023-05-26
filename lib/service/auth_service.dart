import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sebi_car/model/user_model.dart';

class FirebaseService {
  List<DocumentSnapshot> documents = [];
  List<DocumentSnapshot> driverDocuments = [];

  Future<UserModel> getUserData(String userId) async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection("userInfo")
          .doc(userId)
          .get();
      if (snapshot.exists) {
        UserModel userData = UserModel.fromSnapshot(snapshot);
        return userData;
      } else {
        throw "Kullanıcı verisi bulunamadı.";
      }
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> authSaveUserData(
    String nameController,
    String emailController,
    String passwordController,
    String userId,
  ) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('userInfo');

      await users.doc(userId).set({
        "name": nameController,
        "email": emailController,
        "password": passwordController,
        "userId": userId
      });
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> authSavePassangerInfo(
    String userId,
    String fromWhere,
    String toWhere,
    DateTime selectedDate,
  ) async {
    try {
      await FirebaseFirestore.instance
          .collection('userInfo')
          .doc(userId)
          .collection("passenger")
          .doc()
          .set(
        {
          "fromWhere": fromWhere,
          "toWhere": toWhere,
          "selectedDate": selectedDate,
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> authSaveDriverInfo(
    String name,
    String forDriverfromWhere,
    String forDrivertoWhere,
    DateTime selectedCal,
    String selectedTime,
    String price,
  ) async {
    try {
      await FirebaseFirestore.instance.collection("driver").doc().set(
        {
          "name": name,
          "fromWhere": forDriverfromWhere,
          "toWhere": forDrivertoWhere,
          "selectedCalender": DateTime(
            selectedCal.year,
            selectedCal.month,
            selectedCal.day,
          ),
          "selectedTime": selectedTime,
          "price": price,
        },
      );
    } catch (e) {
      throw e.toString();
    }
  }

  Future<QuerySnapshot<Map<String, dynamic>>> authSearchTravel(
    String searchFromWhere,
    String searchToWhere,
    DateTime selectedCal,
  ) async {
    try {
      final driverCollection = FirebaseFirestore.instance.collection('driver');

      final snapshot = await driverCollection
          .where("fromWhere", isEqualTo: searchFromWhere)
          .where("toWhere", isEqualTo: searchToWhere)
          .where("selectedCalender", isEqualTo: selectedCal)
          .get();
      return snapshot;
    } catch (e) {
      throw e.toString();
    }
  }

  Future<User?> authCreateEmailAndPssword(String email, String password) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      return userCredential.user;
    } catch (e) {
      throw Exception('Kullanıcı Oluşturma Başarısız');
    }
  }

  Future<User?> authSignInWithEmailAndPassword(
      String email, String password) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('userInfo');

      QuerySnapshot querySnapshot = await users
          .where('email', isEqualTo: email)
          .where('password', isEqualTo: password)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        return userCredential.user;
      } else {
        throw ('Kullanıcı Bulunamadı');
      }
    } catch (e) {
      throw ('Giriş Başarısız!!!');
    }
  }

  Future<UserCredential> authSignInWithGoogle() async {
    final GoogleSignInAccount? googleSignInAccount =
        await GoogleSignIn().signIn();

    if (googleSignInAccount != null) {
      if (googleSignInAccount.email.endsWith('edu.tr')) {
        final GoogleSignInAuthentication gAuth =
            await googleSignInAccount.authentication;

        final credential = GoogleAuthProvider.credential(
          accessToken: gAuth.accessToken,
          idToken: gAuth.idToken,
        );

        return FirebaseAuth.instance.signInWithCredential(credential);
      } else {
        throw ('Okul Mailiniz İle Giriş Yapınız Lütfen');
      }
    } else {
      throw ('Giriş Başarılı olamadı');
    }
  }

  Future<void> authSignUpWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    if (googleUser != null) {
      if (googleUser.email.endsWith('edu.tr')) {
        final GoogleSignInAuthentication googleAuth =
            await googleUser.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );

        final UserCredential userCredential =
            await FirebaseAuth.instance.signInWithCredential(credential);

        final String? userName = userCredential.user?.displayName;
        if (userName != null) {
          final CollectionReference usersRef =
              FirebaseFirestore.instance.collection('userInfo');

          await usersRef.doc(userCredential.user!.uid).set({
            'username': userName,
            'email': userCredential.user!.email,
          });
        }
      } else {
        throw 'Lütfen Okul Mailiniz İle Giriş Yapınız';
      }
    } else {
      throw 'Giriş Başarılı olamadı';
    }
  }
}
