import 'package:flutter/material.dart';
import 'package:zchat/models/user_model.dart';
import 'package:zchat/utils/base_auth.dart';
import 'package:zchat/utils/navigator.dart';
import 'package:zchat/views/home.dart';

class LoginViewModel extends ChangeNotifier {
  var formKey = GlobalKey<FormState>();
  BaseAuth auth = Auth();


  bool _isLoading = false;
  bool get isLoading => _isLoading;

  set isLoading(bool val) {
    _isLoading = val;
    notifyListeners();
  }

  final TextEditingController emailTEC = new TextEditingController();
  final TextEditingController passwordTEC = new TextEditingController();

  login(BuildContext context) async {
    try {
      _isLoading = true;
      notifyListeners();
      var user = await auth.signIn(emailTEC.text, passwordTEC.text);
      UserModel userModel = await auth.getUserProfile(user.uid);

      notifyListeners();
      print('Logged in As - ${userModel.name}');

      if (user != null) {
        context.navigateReplace(HomePage(userModel));
      }
      isLoading = false;
      notifyListeners();
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print(e.toString());
      if (e.toString().contains('ERROR_WRONG_PASSWORD')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Invalid Password"),
                  content: new Text(
                      "The password is invalid or the user does not have a password."),
                ));
      } else if (e.toString().contains('ERROR_TOO_MANY_REQUESTS')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text(
                      "Too many unsuccessful login attempts. Try again later"),
                ));
      } else if (e.toString().contains('ERROR_USER_NOT_FOUND')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text("This User does not exist."),
                ));
      } else if (e.toString().contains('not a')) {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text(e.toString() ?? ''),
                ));
      } else {
        showDialog(
            context: context,
            builder: (_) => new AlertDialog(
                  title: new Text("Error"),
                  content: new Text("An Error Occurred"),
                ));
      }
    }
  }
}
