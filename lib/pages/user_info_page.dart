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
    //ignore: close_sinks
    AppBloc bloc = BlocProvider.of<AppBloc>(context);
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Info"),
        ),
        body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemBuilder: (BuildContext context, int index) => ImageRow(
                // Header doesn't have an image
                image: index > 0 ? bloc.state.images[index - 1] : null,
                index: index,
              ),
              itemCount: bloc.state.images.length + 1,
            )),
        floatingActionButton: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: FloatingActionButton(
                child: Icon(Icons.exit_to_app),
                onPressed: () {
                  Constants.prefs.setBool(Constants.loggedInPrefKey, false);
                  Constants.prefs.setString(Constants.usernamePrefKey, null);
                  Constants.prefs.setString(Constants.passwordPrefKey, null);
                  Constants.prefs
                      .setString(Constants.barcodeResultPrefKey, null);
                  Constants.prefs.setString(Constants.profileImagePath, null);
                  BlocProvider.of<AppBloc>(context).add(AppSignOutSent());
                },
              ),
            ),
            if (bloc.state.images.length < 4)
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: FloatingActionButton(
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
              ),
          ],
        ),
      ),
    );
  }
}

class ImageRow extends StatelessWidget {
  final CapturedImage image;
  final int index;
  const ImageRow({Key key, @required this.image, @required this.index})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // ignore: close_sinks
    var bloc = BlocProvider.of<AppBloc>(context);
    //Header
    if (index == 0) {
      String profileImagePath = bloc.state.profileImagePath;
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              CircleAvatar(
                radius: 20,
                backgroundImage: profileImagePath == null
                    ? AssetImage('assets/avatar-placeholder.png')
                    : FileImage(File(profileImagePath)),
              ),
              Text('Hi ${bloc.state.username}!'),
              Text('Barcode: ${bloc.state.barcodeResult}'),
              SizedBox(height: 16),
              if (bloc.state.images.length > 0)
                Text(
                  'Long press to set image as profile picture\nSwipe to delete image',
                  textAlign: TextAlign.center,
                ),
            ]),
      );
    } else {
      return Dismissible(
        key: Key(image.path),
        onDismissed: (direction) {
          // ignore: close_sinks
          bloc.add(ImageDeleted(
            state: bloc.state,
            deleteIndex: index - 1 /*compensate for header*/,
          ));

          Scaffold.of(context).showSnackBar(SnackBar(
            content: Text("Image number ${index.toString()} deleted"),
          ));
        },
        background: Container(color: Colors.red),
        child: ListTile(
          onLongPress: () {
            bloc.add(ProfileImageSelected(
              state: bloc.state,
              profileImagePath: image.path,
            ));

            Constants.prefs.setString(Constants.profileImagePath, image.path);

            Scaffold.of(context).showSnackBar(SnackBar(
              content:
                  Text("Image number ${index.toString()} chosen as profile"),
            ));
          },
          leading: Image.file(
            File(image.path),
          ),
          title: Text(
            'Latitude : ${image.latitude} - Longtitude : ${image.longtitude}',
          ),
        ),
      );
    }
  }
}
