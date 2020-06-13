import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:zchat/services/register_providers.dart';
import 'package:zchat/utils/theme.dart';
import 'package:zchat/views/auth/login.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: registerProviders,
      child: MaterialApp(
        title: 'ZChat',
        debugShowCheckedModeBanner: false,
        theme: themeData(context),
        home: Login(),
      ),
    );
  }
}
