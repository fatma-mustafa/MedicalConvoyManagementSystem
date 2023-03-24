import 'package:flutter/foundation.dart';

class HabitsOfMImportance extends ChangeNotifier {
  bool _selectedStatus = false;
  bool get selectedStatus => _selectedStatus;
  set selectedStatus(bool status) {
    _selectedStatus = status;
    notifyListeners();
  }

  String _contraception = "IUD";
  String get contraception => _contraception;
  set contraception(String status) {
    _contraception = status;
    notifyListeners();
  }
}
