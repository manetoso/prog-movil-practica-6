import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class CardProduct extends StatelessWidget {
  const CardProduct({Key? key, required this.productDocument}) : super(key: key);
  final DocumentSnapshot productDocument;

  @override
  Widget build(BuildContext context) {
    final _card = Stack(
    alignment: Alignment.bottomCenter,
      children: [
        // ignore: sized_box_for_whitespace
        Container(
          width: MediaQuery.of(context).size.width,
          child: FadeInImage(
            placeholder: const AssetImage('assets/loading.gif'),
            image: NetworkImage(productDocument['imgprod']),
            fit: BoxFit.cover,
            fadeInDuration: const Duration(milliseconds: 100),
            height: 230.0,
          ),
        ),
        Opacity(
          opacity: .6,
          child: Container(
            height: 55.0,
            color: Colors.black,
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Text(
                    productDocument['cveprod'],
                    style: const TextStyle(color: Colors.white, fontSize: 20.0),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
    return Container(
      margin: const EdgeInsets.all(15.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(.2),
            offset: const Offset(0.0,5.0),
            blurRadius: 1.0
          )
        ]
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10.0),
        child: _card,
      ),
    );
  }
}