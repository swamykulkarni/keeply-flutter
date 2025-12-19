import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _userPhone;
  String? _userName;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get userPhone => _userPhone;
  String? get userName => _userName;

  AuthProvider() {
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    _isLoading = true;
    notifyListeners();

    try {
      final prefs = await SharedPreferences.getInstance();
      _isAuthenticated = prefs.getBool('isAuthenticated') ?? false;
      _userPhone = prefs.getString('userPhone');
      _userName = prefs.getString('userName');
    } catch (e) {
      _isAuthenticated = false;
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> login(String phone, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Demo login - accept any phone/password
    if (phone.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _userPhone = phone;
      _userName = 'Demo User';

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userPhone', phone);
      await prefs.setString('userName', 'Demo User');

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> signup(String name, String phone, String email, String password) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 2));

    // Demo signup - accept any valid data
    if (name.isNotEmpty && phone.isNotEmpty && email.isNotEmpty && password.isNotEmpty) {
      _isAuthenticated = true;
      _userPhone = phone;
      _userName = name;

      // Save to SharedPreferences
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isAuthenticated', true);
      await prefs.setString('userPhone', phone);
      await prefs.setString('userName', name);

      _isLoading = false;
      notifyListeners();
      return true;
    }

    _isLoading = false;
    notifyListeners();
    return false;
  }

  Future<bool> verifyOTP(String otp) async {
    _isLoading = true;
    notifyListeners();

    // Simulate API call delay
    await Future.delayed(const Duration(seconds: 1));

    // Demo OTP - accept any 6-digit OTP
    bool isValid = otp.length == 6 && RegExp(r'^\d+$').hasMatch(otp);

    _isLoading = false;
    notifyListeners();
    return isValid;
  }

  Future<void> logout() async {
    _isAuthenticated = false;
    _userPhone = null;
    _userName = null;

    // Clear SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
  }
}