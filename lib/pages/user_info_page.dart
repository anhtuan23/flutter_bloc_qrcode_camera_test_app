import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserInfoPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("User Info"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.exit_to_app),
          onPressed: () {
            BlocProvider.of<AppBloc>(context).add(AppSignOutSent());
          },
        ),
      ),
    );
  }
}
