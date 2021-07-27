import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart' as uuid;
import 'codemessage.dart';
import 'dao.dart';
import 'datamodel.dart';

abstract class DaoFirebaseDB<DM extends DataModel> extends Dao<DM> {

  String _getCollectionPath() {
    if (FirebaseAuth.instance.currentUser == null) return '';
    if (FirebaseAuth.instance.currentUser!.email == null) return '';
    return '/accounts/' + FirebaseAuth.instance.currentUser!.email! + '/' + getCollectionName();
  }

  String getCollectionName();

  DM createModelFromJson(String id, Map<String, dynamic> json);

  Future<DM?> get(String id) async {
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return null;
    if (id.isEmpty) return null;

    var documentSnapShot = await FirebaseFirestore.instance.collection(collectionPath).doc(id).get();
    if ((documentSnapShot.exists) && (documentSnapShot.data() != null))
      return createModelFromJson(id, documentSnapShot.data()!);
    else
      return null;
  }

  Future<List<DM>> getAll() async {
    List<DM> list = List.empty(growable: true);
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return list;
    var querySnapshot = await FirebaseFirestore.instance.collection(collectionPath).get();
    querySnapshot.docs.forEach((doc) {;
      if ((doc.exists)) {
        list.add(createModelFromJson(doc.id, doc.data()));
      }
    });
    return list;
  }

  Future<CodeMessage> put(DM dataModel) async {
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return CodeMessage(100, 'User is not authenticated!!');
    try {
      DocumentReference documentReference = FirebaseFirestore.instance.collection(collectionPath).doc(dataModel.id);
      FirebaseFirestore.instance.runTransaction((transaction) async {
        transaction.set(documentReference, dataModel.toJson());
      });
      return CodeMessage(1, "");
    } catch (error) {
      return CodeMessage(100, error.toString());
    }
  }

  Future<CodeMessage> create(DM dataModel) async {
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return CodeMessage(200, 'User is not authenticated!!');
    try {
      dataModel.id = uuid.Uuid().v4().toString();
      return put(dataModel);
    } catch (error) {
      return CodeMessage(200, error.toString());
    }
  }

  Future<CodeMessage> delete(String id) async {
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return CodeMessage(300, 'User is not authenticated!!');
    if (id.isEmpty) return CodeMessage(300, 'id is empty!');
    try {
      await FirebaseFirestore.instance.collection(collectionPath).doc(id).delete();
      return CodeMessage(1, "");
    } catch (error) {
      return CodeMessage(300, error.toString());
    }
  }

  Future<List<DM>>  getAllUsingPropertyValue(String propertyName, String propertyValue) async {

    List<DM> list = List.empty(growable: true);
    String collectionPath = _getCollectionPath();
    if (collectionPath.isEmpty) return list;
    var querySnapshot = await FirebaseFirestore.instance.collection(collectionPath).where(propertyName, isEqualTo: propertyValue).get();


    querySnapshot.docs.forEach((doc) {

      if ((doc.exists)) {
        list.add(createModelFromJson(doc.id, doc.data()));
      }
    });
    return list;
  }

}
