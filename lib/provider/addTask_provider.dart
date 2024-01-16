import 'package:flutter/foundation.dart';

class AddTaskProvider with ChangeNotifier{

  bool _mainAddButtonVisibility = true;
  bool get mainAddButtonVisibility => _mainAddButtonVisibility;

  bool _isTextNotEmpty = false;
  bool get isTextNotEmpty => _isTextNotEmpty;

  void updateText(String taskText) {
    _isTextNotEmpty = taskText.isNotEmpty;  // true : appear, false: disappear icon
    notifyListeners();
  }

  void clearText(){
    _isTextNotEmpty=false;
    notifyListeners();
  }

  void setMainAddButton(bool value){
    _mainAddButtonVisibility=value;
    notifyListeners();
  }

}