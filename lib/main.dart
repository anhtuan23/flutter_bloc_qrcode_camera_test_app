import 'package:bloc_barcode_camera_demo_app/pages/barcode_scanning_page.dart';
import 'package:bloc_barcode_camera_demo_app/pages/sign_up_page.dart';
import 'package:bloc_barcode_camera_demo_app/pages/user_info_page.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'bloc/appbloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:shared_preferences/shared_preferences.dart';

import 'package:camera/camera.dart';

import 'pages/picture_capturing_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Constants.prefs = await SharedPreferences.getInstance();
  runApp(BlocProvider(
    create: (context) => AppBloc(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // ignore: missing_return
      home: BlocBuilder<AppBloc, AppBlocState>(builder: (context, state) {
        if (state is AppBlocSignedOut) {
          return BarcodeScanningPage();
        } else if (state is AppBlocSigningUp) {
          return SignUpPage();
        } else if (state is AppBlocSignedUp) {
          return UserInfoPage();
        } else if (state is AppBlocTakingPicture) {
          return PictureCapturingPage();
        }
      }),
    );
  }
}
