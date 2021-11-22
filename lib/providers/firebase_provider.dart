import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:practica_6/models/product_dao.dart';

class FireBaseProvider {
  late FirebaseFirestore _firestore;
  late CollectionReference _productsCollection;

  UploadTask? uploadImage(String destination, File file) {
    try {
      final ref = FirebaseStorage.instance.ref(destination);
      return ref.putFile(file);
    } on FirebaseException catch (e) {
      return null;
    }
  }

  FireBaseProvider() {
    _firestore = FirebaseFirestore.instance;
    _productsCollection = _firestore.collection('products');
  }

  Future<void> saveProduct(ProductDAO objDAO) {
    return _productsCollection.add(objDAO.toMap());
  }

  Future<void> updateProduct(ProductDAO objDAO, String documentId) {
    return _productsCollection.doc(documentId).update(objDAO.toMap());
  }

  Future<void> deleteProduct(String documentId) {
    return _productsCollection.doc(documentId).delete();
  }

  Stream<QuerySnapshot> getAllProducts() {
    return _productsCollection.snapshots();
  }
}