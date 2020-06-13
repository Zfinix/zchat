import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:zchat/view_models/home_vm.dart';
import 'package:zchat/view_models/login_vm.dart';
import 'package:zchat/view_models/signup_vm.dart';

final registerProviders = <SingleChildWidget>[
  ChangeNotifierProvider(create: (_) => HomeViewModel()),
  ChangeNotifierProvider(create: (_) => LoginViewModel()),
  ChangeNotifierProvider(create: (_) => SignupViewModel()),
];
