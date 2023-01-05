import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> updateValue(String ref, String? username, var data,
    FirebaseFirestore firestoreInstance) async {
  firestoreInstance.collection(ref).doc(username).update(data).then((value) {
    print('Sent successfully');
  });
}
