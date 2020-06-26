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
      home: BlocBuilder<AppBloc, AppBlocState>(
        builder: (context, state) =>
            state is AppBlocSignedOut ? SignUpPage() : UserInfoPage(),
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
            BlocProvider.of<AppBloc>(context)
                .add(AppBlocEvents.AppSignUpSent);
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
            BlocProvider.of<AppBloc>(context)
                .add(AppBlocEvents.AppSignOutSent);
          },
        ),
      ),
    );
  }
}
