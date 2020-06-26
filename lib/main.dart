import 'package:bloc_barcode_camera_demo_app/pages/barcode_scanning_page.dart';
import 'package:bloc_barcode_camera_demo_app/pages/sign_up_page.dart';
import 'package:bloc_barcode_camera_demo_app/pages/user_info_page.dart';
import 'package:flutter/material.dart';

import 'bloc/appbloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
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
      home: BlocBuilder<AppBloc, AppBlocState>(builder: (context, state) {
        if (state is AppBlocSignedOut) {
          return BarcodeScanningPage();
        } else if (state is AppBlocSigningUp) {
          return SignUpPage();
        } else {
          return UserInfoPage();
        }
      }),
    );
  }
}

