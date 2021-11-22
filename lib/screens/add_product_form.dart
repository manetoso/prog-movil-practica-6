import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:practica_6/models/product_dao.dart';
import 'package:practica_6/providers/firebase_provider.dart';
import 'package:practica_6/providers/provider_form_filds.dart';
import 'package:practica_6/ui/input_decoration.dart';
import 'package:provider/provider.dart';

class AddProductForm extends StatefulWidget {
  const AddProductForm({Key? key}) : super(key: key);

  @override
  _AddProductFormState createState() => _AddProductFormState();
}

class _AddProductFormState extends State<AddProductForm> {
  late FireBaseProvider _fireBaseProvider;

  File? _image;
  String? _imagePath;
  UploadTask? task;

  @override
  void initState() {
    super.initState();
    _fireBaseProvider = FireBaseProvider();
  }

  Future pickImage(ImageSource source, BuildContext context) async {
    try {
      final image = await ImagePicker().pickImage(source: source);
      if (image == null) return;

      final imageTemporary = File(image.path);

      final imgName = basename(image.path);
      setState(() {
        _image = imageTemporary;
        _imagePath = imgName;
      });
    } on PlatformException catch (e) {
      // ignore: avoid_print
      print('Filed to pick image: $e');
    }
  }

  Future uploadFile() async {
    if (_image == null) return;
    final fileName = _imagePath;
    final destination = 'files/$fileName';
    task = _fireBaseProvider.uploadImage(destination, _image!);
    setState(() {});
    
    if (task == null) return;
    final snapshot = await task!.whenComplete(() {});
    final urlDownload = await snapshot.ref.getDownloadURL();
    return urlDownload;
  }

  @override
  Widget build(BuildContext context) {
    final formField = Provider.of<FormFieldsProvider>(context);
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar un producto'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: size.height * 0.02,),
            const Text('Agregar Clave del producto'),
            TextFormField(
              autocorrect: false,
              decoration: InputDecorations.customInputDecoration(
                hintText: '12946',
                labelText: 'Clave de producto'
              ),
              onChanged: (value) => formField.cveProd = value,
            ),
            const SizedBox(height: 20.0,),
            const Text('Agregar Descripción del producto'),
            TextFormField(
              autocorrect: false,
              decoration: InputDecorations.customInputDecoration(
                hintText: 'Producto que sirve para...',
                labelText: 'Descripción del producto'
              ),
              onChanged: (value) => formField.descProd = value,
            ),
            const SizedBox(height: 20.0,),
            const Text('Imagen del producto'),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  children: [
                    const SizedBox(height: 40.0,),
                    _image != null
                      ? Image.file(
                        _image!,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                      : const Text('No se ha seleccionado imagen'),
                    const SizedBox(height: 40.0,),
                    ElevatedButton(
                      onPressed: () async {
                        await pickImage(ImageSource.gallery, context);
                        if (_imagePath != null) {
                          formField.imgProd = _imagePath!;
                        }
                      },
                      child: const Text('Seleccionar imagen')
                    ),
                    task != null ? buildUploadStatus(task!) : Container()
                  ],
                )
              ],
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          formField.isLoading = true;
          final imgRef = await uploadFile();
          final newProd = ProductDAO(
            cveprod: formField.cveProd,
            descprod: formField.descProd,
            imgprod: imgRef,
          );
          await _fireBaseProvider.saveProduct(newProd);
          await Future.delayed(const Duration(milliseconds: 200));
          formField.isLoading = true;
          // Navigator.pushReplacementNamed(context, 'home');
          Navigator.pop(context);
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget buildUploadStatus(UploadTask uploadTask) => StreamBuilder<TaskSnapshot>(
    stream: task!.snapshotEvents,
    builder: (context, snaptshot) {
      if (snaptshot.hasData) {
        final snap = snaptshot.data!;
        final progress = snap.bytesTransferred / snap.totalBytes;
        final percentage = (progress * 100).toStringAsFixed(2);
        return Text(
          '$percentage %',
          style: const TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
        );
      } else {
        return Container();
      }
    },
  );
}