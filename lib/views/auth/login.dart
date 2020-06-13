import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:zchat/utils/margin.dart';
import 'package:zchat/utils/navigator.dart';
import 'package:zchat/utils/theme.dart';
import 'package:zchat/utils/validator.dart';
import 'package:zchat/view_models/login_vm.dart';
import 'package:zchat/widgets/loader.dart';
import 'package:zchat/widgets/text_views.dart';

import 'signup.dart';

class Login extends StatefulWidget {
  Login({Key key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<LoginViewModel>();

    return Material(
      child: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage('assets/images/bg.jpg'))),
       
        child: Stack(
          children: [
            Container(
              constraints: BoxConstraints.expand(),
              color: black.withOpacity(0.7),
            ),
            ListView(
              children: [
                Container( padding: EdgeInsets.all(20),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        YMargin(context.screenHeight(percent: 0.08)),
                        Text(
                          'Žchat',
                          style: GoogleFonts.notoSans(
                            textStyle: TextStyle(
                                color: white,
                                fontSize: 39,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        const YMargin(80),
                        Form(
                          key: provider.formKey,
                          child: Container(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                const YMargin(40),
                                ZChatTextField(
                                  isDark: true,
                                  validator: (value) {
                                    if (Validator.isEmail(value)) {
                                      return null;
                                    } else if (value.isEmpty) {
                                      return "This field can't be left empty";
                                    } else {
                                      return "Please enter a valid Email";
                                    }
                                  },
                                  controller: provider?.emailTEC,
                                  hintText: 'Email',
                                ),
                                const YMargin(20),
                                ZChatTextField( isDark: true,
                                  validator: (value) {
                                    if (Validator.isPassword(value)) {
                                      return null;
                                    } else if (value.isEmpty) {
                                      return "This field can't be left empty";
                                    } else {
                                      return "Please enter a valid Password";
                                    }
                                  },
                                  hintText: 'Password',
                                  controller: provider?.passwordTEC,
                                  isPassword: true,
                                ),
                                YMargin(context.screenHeight(percent: 0.1)),
                                provider.isLoading
                                    ? Loader()
                                    : Container(
                                        width: context.screenWidth(),
                                        margin:
                                            EdgeInsets.symmetric(horizontal: 30),
                                        height: 60,
                                        child: FlatButton(
                                          color: primary,
                                          onPressed: () {
                                            if (provider.formKey.currentState
                                                .validate())
                                              provider.login(context);
                                          },
                                          child: Text(
                                            'Login',
                                            style: TextStyle(
                                                fontSize: 15,
                                                color: white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                const YMargin(30),
                                InkResponse(
                                  onTap: () => context.navigate(Signup()),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Text(
                                        'Don’t have an account?  ',
                                        style: TextStyle(
                                            fontSize: 14, color: Colors.green),
                                      ),
                                      Text(
                                        'Sign up',
                                        style: TextStyle(
                                            fontSize: 14,
                                            color: white,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                                const YMargin(90),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
