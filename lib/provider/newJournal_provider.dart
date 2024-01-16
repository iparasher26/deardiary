import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class NewJournalProvider with ChangeNotifier{

  bool _isBodyNotEmpty = false;
  bool get isBodyNotEmpty => _isBodyNotEmpty;

  bool _isTitleNotEmpty = false;
  bool get isTitleNotEmpty => _isTitleNotEmpty; // true : appear, false: disappear icon


  void updateBody(String body) {
    _isBodyNotEmpty = body.isNotEmpty;  // true : appear, false: disappear icon
    notifyListeners();
  }

  void updateTitle(String title) {
    _isTitleNotEmpty = title.isNotEmpty;  // true : appear, false: disappear icon
    notifyListeners();
  }

  void clearAll(){
    _isTitleNotEmpty=false;
    _isBodyNotEmpty=false;
    notifyListeners();
  }




}