import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:practica_6/providers/firebase_provider.dart';
import 'package:practica_6/views/card_product.dart';

class ListProducts extends StatefulWidget {
  const ListProducts({Key? key}) : super(key: key);

  @override
  _ListProductsState createState() => _ListProductsState();
}

class _ListProductsState extends State<ListProducts> {
  late FireBaseProvider _fireBaseProvider;

  @override
  void initState() {
    super.initState();
    _fireBaseProvider = FireBaseProvider();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Firestore'),
        actions: [
          IconButton(
            onPressed: (){
              Navigator.pushNamed(context, 'add');
            },
            icon: const Icon(Icons.add)
          )
        ],
      ),
      body: StreamBuilder(
        stream: _fireBaseProvider.getAllProducts(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData) return const Center(child: CircularProgressIndicator());
          return ListView(
            children: snapshot.data!.docs.map((DocumentSnapshot document) {
              return CardProduct(productDocument: document);
            }).toList(),
          );
        },
      ),
    );
  }
}