import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:zchat/models/user_model.dart';
import 'package:zchat/utils/base_auth.dart';
import 'package:zchat/utils/navigator.dart';
import 'package:zchat/views/home.dart';

class SignupViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  BaseAuth auth = Auth();

  final TextEditingController emailTEC = new TextEditingController();
  final TextEditingController nameTEC = new TextEditingController();
  final TextEditingController phoneTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  String _countryCode = '+1';
  String get countryCode => _countryCode;

  String _country = 'United States';
  String get country => _country;

  String _phone;
  String get phone => _phone;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  set phone(String val) {
    _phone = val;
    notifyListeners();
  }

  
  void onCountryChange(CountryCode val) {
    _countryCode = val.dialCode;
    _country = val.name;
    notifyListeners();
  }

  signup(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      var user = await auth.signUp(emailTEC.text, passwordTEC.text);
      if (user != null) {}
      UserModel userModel = UserModel(
          name: nameTEC.text,
          email: emailTEC.text,
          phone: _phone,
          profilePicUrl: '',
          userId: user.uid,
          isAdmin: false);

      await auth.createUserProfile(userModel);
      emailTEC.text = '';
      nameTEC.text = '';
      passwordTEC.text = '';
      notifyListeners();

      print('Signed up as - ${userModel.name}');

    // if (user != null) context.navigate(SelectPlan(userModel));
      if (user != null) context.navigateReplace(HomePage(userModel));
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
    }
  }
}
