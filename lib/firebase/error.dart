// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/signInWithEmailAndPassword.html
const List<String> signInEaPError = [
  'invalid-email',
  'user-disabled',
  'user-not-found',
  'wrong-password',
  'too-many-requests',
  'operation-not-allowed',
  'network-request-failed',
];

// https://pub.dev/documentation/firebase_auth/latest/firebase_auth/FirebaseAuth/createUserWithEmailAndPassword.html
const List<String> createEaPError = [
  'email-already-in-use',
  'invalid-email',
  'operation-not-allowed',
  'weak-password',
  'too-many-requests',
  'operation-not-allowed',
  'network-request-failed',
];
