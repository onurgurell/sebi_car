import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseService {
  List<DocumentSnapshot> documents = [];

  Future<void> saveUserData(
    String nameController,
    String emailController,
    String passwordController,
  ) async {
    try {
      CollectionReference users =
          FirebaseFirestore.instance.collection('userInfo');

      await users.doc().set({
        "name": nameController,
        "email": emailController,
        "password": passwordController,
      });
    } catch (e) {
      print("Service Error ${e.toString()}");
    }
  }

  Future<User?> createEmailAndPssword(String email, String password) async {
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

  Future<User?> signInWithEmailAndPassword(
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
        throw Exception('Kullanıcı Bulunamadı');
      }
    } catch (e) {
      throw Exception('Giriş Başarısız!!!');
    }
  }

  Future<UserCredential> singInWithGoogle() async {
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

  Future<void> signUpWithGoogle() async {
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
        throw ('Kayıt Başarılı Bir Şekilde Gerçekleştirildi');
      } else {
        throw ('Lütfen Okul Mailiniz İle Giriş Yapınız');
      }
    } else {
      throw ('Giriş Başarılı olamadı');
    }
  }
}
