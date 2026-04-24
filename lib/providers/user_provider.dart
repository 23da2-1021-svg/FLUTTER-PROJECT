import 'package:flutter/foundation.dart';
import '../models/user_model.dart';

class UserProvider extends ChangeNotifier {
  UserModel? _user;
  bool _isLoggedIn = false;

  UserModel? get user => _user;
  bool get isLoggedIn => _isLoggedIn;

  void login(String fullName, String email) {
    _user = UserModel(
      id: 'u001',
      fullName: fullName,
      email: email,
    );
    _isLoggedIn = true;
    notifyListeners();
  }

  void logout() {
    _user = null;
    _isLoggedIn = false;
    notifyListeners();
  }

  void updateProfile(String fullName, String email) {
    if (_user != null) {
      _user = UserModel(id: _user!.id, fullName: fullName, email: email);
      notifyListeners();
    }
  }
}
