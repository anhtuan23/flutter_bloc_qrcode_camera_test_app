import 'dart:io';

import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoPage extends StatefulWidget {
  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<UserInfoPage> {
  @override
  Widget build(BuildContext context) {
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Info"),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Barcode result: ${bloc.state.barcodeResult}'),
                Text('Username : ${bloc.state.username}'),
                Image.file(File(bloc.state.imagePaths.length > 0 ? bloc.state.imagePaths[0] : ""))
              ],
            ),
          ),
        ),
        floatingActionButton: Row(
          children: <Widget>[
            FloatingActionButton(
              child: Icon(Icons.exit_to_app),
              onPressed: () {
                Constants.prefs.setBool(Constants.loggedInPrefKey, false);
                Constants.prefs.setString(Constants.usernamePrefKey, null);
                Constants.prefs.setString(Constants.passwordPrefKey, null);
                Constants.prefs.setString(Constants.barcodeResultPrefKey, null);
                BlocProvider.of<AppBloc>(context).add(AppSignOutSent());
              },
            ),
            FloatingActionButton(
              child: Icon(Icons.camera_alt),
              onPressed: () {
                BlocProvider.of<AppBloc>(context).add(
                  CameraRequestSent(
                    username: bloc.state.username,
                    password: bloc.state.password,
                    barcodeResult: bloc.state.barcodeResult,
                    imagePaths: bloc.state.imagePaths,
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

// A widget that displays the picture taken by the user.
class DisplayPictureScreen extends StatelessWidget {
  final String imagePath;

  const DisplayPictureScreen({Key key, this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Display the Picture')),
      // The image is stored as a file on the device. Use the `Image.file`
      // constructor with the given path to display the image.
      body: Image.file(File(imagePath)),
    );
  }
}
