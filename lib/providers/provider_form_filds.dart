import 'package:flutter/material.dart';

class FormFieldsProvider extends ChangeNotifier {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String cveProd = '';
  String descProd = '';
  String imgProd = '';

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading( bool value ) {
    _isLoading = value;
    notifyListeners();
  }
}