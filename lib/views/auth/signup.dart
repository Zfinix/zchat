import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/utils/margin.dart';
import 'package:zchat/utils/theme.dart';
import 'package:zchat/utils/validator.dart';
import 'package:zchat/view_models/signup_vm.dart';
import 'package:zchat/widgets/loader.dart';
import 'package:zchat/widgets/text_views.dart';

class Signup extends StatefulWidget {
  @override
  _SignupState createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    var provider = context.watch<SignupViewModel>();
    return Scaffold(
      backgroundColor: altBg,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: white,
      ),
      body: Form(
        key: provider.formKey,
        child: Container(
          color: Colors.white,
          child: ListView(
            children: <Widget>[
              const YMargin(20),
              Padding(
                padding: const EdgeInsets.only(left: 30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Signup.',
                      style: TextStyle(
                          fontSize: 25,
                          color: textColor,
                          fontWeight: FontWeight.w900),
                    ),
                    const YMargin(6),
                    Text(
                      'Create a Žchat Account',
                      style: TextStyle(
                          fontSize: 12,
                          color: textColor,
                          fontWeight: FontWeight.w100),
                    ),
                    const YMargin(40),
                  ],
                ),
              ),
              const YMargin(20),
              ZChatTextField(
                validator: (value) {
                  if (value.isNotEmpty) {
                    return null;
                  } else if (value.isEmpty) {
                    return "This field can't be left empty";
                  } else {
                    return "Please enter a valid Name";
                  }
                },
                controller: provider?.nameTEC,
                hintText: 'Full Name',
              ),
              const YMargin(20),
              ZChatTextField(
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
              Container(
                margin: EdgeInsets.symmetric(horizontal: 10, vertical: 18)
                    .add(EdgeInsets.only(right: 20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(1),
                          child: Row(
                            children: <Widget>[
                              const XMargin(10),
                              CountryCodePicker(
                                onChanged: provider.onCountryChange,
                                // Initial selection and favorite can be one of code ('IT') OR dial_code('+39')
                                initialSelection: 'US',
                                textStyle: TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Color.fromRGBO(87, 93, 107, 1)),
                                favorite: ['+1', 'US'],

                                // optional. Shows only country name and flag
                                showFlag: true,
                                showCountryOnly: true,
                                // optional. Shows only country na
                                // optional. aligns the flag and the Text left
                                alignLeft: false,
                              ),
                              Icon(Icons.arrow_drop_down,
                                  color: Colors.grey[300])
                            ],
                          ),
                        ),
                        const XMargin(10),
                        Flexible(
                          flex: 5,
                          child: Container(
                            child: TextFormField(
                              validator: (value) {
                                if (value.length >= 10) {
                                  provider.phone =
                                      '${provider?.countryCode ?? "+234"}' +
                                          value;

                                  return null;
                                } else if (value.isEmpty) {
                                  return "This field can't be left empty";
                                } else {
                                  return "Invalid phone number";
                                }
                              },
                              controller: provider.phoneTEC,
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  fontSize: 15,
                                  color: textColor),
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.symmetric(
                                    horizontal: 30, vertical: 20),
                                fillColor: altBg,
                                hintText: 'Phone Number',
                                errorStyle: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 11,
                                    color: Colors.red),
                                hintStyle: TextStyle(
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15,
                                    color: textColor.withOpacity(0.4)),
                                filled: true,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200],
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.red[400],
                                  ),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.red[400],
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200],
                                  ),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey[200],
                                  ),
                                ),
                                disabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(4),
                                  borderSide: BorderSide(
                                    color: Colors.grey[100],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              ZChatTextField(
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
              YMargin(context.screenHeight(percent: 0.08)),
              provider.isLoading
                  ? Loader()
                  : Container(
                      width: context.screenWidth(),
                      margin: EdgeInsets.symmetric(horizontal: 30),
                      height: 55,
                      child: FlatButton(
                        color: primary,
                        onPressed: () {
                          if (provider.formKey.currentState.validate())
                            provider.signup(context);
                        },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              fontSize: 15,
                              color: white,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
              const YMargin(30),
              InkWell(
                onTap: () {
                  Navigator.of(context).pop();
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'Already have an account?  ',
                      style: TextStyle(fontSize: 14, color: textColor),
                    ),
                    Text(
                      'Sign In',
                      style: TextStyle(fontSize: 14, color: primary),
                    ),
                  ],
                ),
              ),
              const YMargin(90),
            ],
          ),
        ),
      ),
    );
  }
}
