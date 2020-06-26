import 'package:flutter/material.dart';

import 'bloc/appbloc_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(BlocProvider(
    create: (context) => AppblocBloc(),
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
      home: BlocBuilder<AppblocBloc, AppblocState>(
        builder: (context, state) =>
            state is AppblocSignedOut ? SignUpPage() : UserInfoPage(),
      ),
    );
  }
}

class SignUpPage extends StatelessWidget {
  const SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Sign Up"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.camera),
          onPressed: () {
            BlocProvider.of<AppblocBloc>(context)
                .add(AppblocEvents.AppSignUpSent);
          },
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
            BlocProvider.of<AppblocBloc>(context)
                .add(AppblocEvents.AppSignOutSent);
          },
        ),
      ),
    );
  }
}
