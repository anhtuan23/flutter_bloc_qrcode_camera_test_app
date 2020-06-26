import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Signing Up"),
        ),
        body: BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return Center(
              child: Text("Enter Info"),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.send),
          onPressed: () {},
        ),
      ),
    );
  }
}
