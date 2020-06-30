import 'dart:io';

import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc_barcode_camera_demo_app/models/models.dart';

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
                  ImageRow(image: bloc.state.images[index]),
              itemCount: bloc.state.images.length,
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
                    images: bloc.state.images,
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
  final CapturedImage image;
  const ImageRow({Key key, @required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.file(
        File(image.path),
      ),
      title: Text(
          'Latitude : ${image.latitude} - Longtitude : ${image.longtitude}'),
    );
  }
}
