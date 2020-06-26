import 'package:flutter/material.dart';

import 'bloc/appbloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:barcode_scan/barcode_scan.dart';

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

class BarcodeScanningPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Barcode Scanning"),
        ),
        body: BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return Center(
              child: Text(state.message),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () async {
            var result = await BarcodeScanner.scan();
            switch (result.type) {
              case ResultType.Barcode:
                BlocProvider.of<AppBloc>(context)
                    .add(AppBarcodeResultReceived(result.rawContent));
                break;
              case ResultType.Cancelled:
              case ResultType.Error:
              default:
                BlocProvider.of<AppBloc>(context)
                    .add(AppBarcodeResultErrorReceived());
            }
          },
        ),
      ),
    );
  }
}
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

class UserInfoPage extends StatelessWidget {
  const UserInfoPage({Key key}) : super(key: key);

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
