import "dart:io";

import "package:firebase_storage/firebase_storage.dart";

class FileRepository {
  final FirebaseStorage _firebaseStorage;

  FileRepository(this._firebaseStorage);

  Future uploadFile(File file, String nome) async {
    final String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    final StorageReference reference = _firebaseStorage.ref().child("users/"+nome+"."+fileName+ ".jpg");
    final StorageUploadTask uploadTask = reference.putFile(file);
    final StorageTaskSnapshot storageTaskSnapshot = await uploadTask.onComplete;
    return storageTaskSnapshot.ref.getDownloadURL();
  }
}
