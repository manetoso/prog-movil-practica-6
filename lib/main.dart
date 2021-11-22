import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:practica_6/providers/provider_form_filds.dart';
import 'package:practica_6/screens/add_product_form.dart';
import 'package:practica_6/screens/products_screen.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Firebase Test',
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      initialRoute: 'home',
      routes: {
        'home': (_) => const ListProducts(),
        'add': (_) => ChangeNotifierProvider(
          create: (_) => FormFieldsProvider(),
          child: const AddProductForm(),
        )
      },
    );
  }
}