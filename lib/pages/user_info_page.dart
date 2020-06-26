import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoPage extends StatelessWidget {
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
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.exit_to_app),
          onPressed: () {
            Constants.prefs.setBool(Constants.loggedInPrefKey, false);
            Constants.prefs.setString(Constants.usernamePrefKey, null);
            Constants.prefs.setString(Constants.passwordPrefKey, null);
            Constants.prefs.setString(Constants.barcodeResultPrefKey, null);
            BlocProvider.of<AppBloc>(context).add(AppSignOutSent());
          },
        ),
      ),
    );
  }
}
