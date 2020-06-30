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
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child:
                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.center,
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: <Widget>[
                //     Text('Barcode result: ${bloc.state.barcodeResult}'),
                //     Text('Username : ${bloc.state.username}'),
                ListView.builder(
              itemBuilder: (BuildContext context, int index) =>
                  ImageRow(imagePath: bloc.state.imagePaths[index]),
              itemCount: bloc.state.imagePaths.length,
            )),
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

class ImageRow extends StatelessWidget {
  final String imagePath;
  const ImageRow({Key key, @required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(
        File(imagePath),
      ),
      title: Text("GPS"),
    );
  }
}
