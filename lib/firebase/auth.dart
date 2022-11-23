import 'package:firebase_auth/firebase_auth.dart';

// const testEmail = 'test2@gmail.com';
// const testPW = '123456789';

Future<String> firebaseCreate({
  required String email,
  required String pw,
}) async {
  try {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: email,
      password: pw,
    );
  } on FirebaseAuthException catch (e) {
    // specific(FirebaseAuthException) error catch
    print('FirebaseAuthException: ${e.code}.');
    return e.code;
  } catch (e) {
    // all error catch
    print('FirebaseAuthException: Unknown Error.');
    return 'Unknown Error';
  }

  return 'Success';
}

Future<String> firebaseSignIn({
  required String email,
  required String pw,
}) async {
  try {
    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: pw,
    );
  } on FirebaseAuthException catch (e) {
// specific(FirebaseAuthException) error catch
    print('FirebaseAuthException: ${e.code}.');
    return e.code;
  } catch (e) {
// all error catch
    print('FirebaseAuthException: Unknown Error.');

    return 'Unknown Error';
  }

  return 'Success';
}

void firebaseLogOut() async {
  await FirebaseAuth.instance.signOut();
}
