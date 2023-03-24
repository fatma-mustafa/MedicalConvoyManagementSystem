import 'package:flutter/foundation.dart';

class MaritalStatus extends ChangeNotifier {
  String _selectedStatus = "";
  String get selectedStatus => _selectedStatus;
  set selectedStatus(String status) {
    _selectedStatus = status;
    notifyListeners();
  }
}
