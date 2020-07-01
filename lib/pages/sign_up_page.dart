import 'package:bloc_barcode_camera_demo_app/bloc/appbloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpPage extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  final _usernameController = TextEditingController();

  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: Text("Signing Up"),
        ),
        body: BlocBuilder<AppBloc, AppBlocState>(
          builder: (context, state) {
            return Stack(
              fit: StackFit.expand,
              children: <Widget>[
                Image.asset(
                  'assets/bg.jpg',
                  fit: BoxFit.cover,
                  color: Colors.black.withOpacity(0.7),
                  colorBlendMode: BlendMode.darken,
                ),
                Center(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: SingleChildScrollView(
                      child: BlocBuilder<AppBloc, AppBlocState>(
                        builder: (context, state) => SignInForm(
                          formKey: formKey,
                          usernameController: _usernameController,
                          passwordController: _passwordController,
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

class SignInForm extends StatelessWidget {
  const SignInForm({
    Key key,
    @required this.formKey,
    @required TextEditingController usernameController,
    @required TextEditingController passwordController,
  })  : _usernameController = usernameController,
        _passwordController = passwordController,
        super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController _usernameController;
  final TextEditingController _passwordController;

  @override
  Widget build(BuildContext context) {
    //ignore: close_sinks
    AppBloc bloc = BlocProvider.of<AppBloc>(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            children: <Widget>[
              Text(bloc.state.barcodeResult),
              TextFormField(
                controller: _usernameController,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                  labelText: 'Username',
                  hintText: 'Enter email',
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                controller: _passwordController,
                keyboardType: TextInputType.text,
                obscureText: true,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter password',
                ),
              ),
              SizedBox(height: 20),
              RaisedButton(
                onPressed: () {
                  Constants.prefs.setBool(Constants.loggedInPrefKey, true);
                  Constants.prefs.setString(
                      Constants.usernamePrefKey, _usernameController.text);
                  Constants.prefs.setString(
                      Constants.passwordPrefKey, _passwordController.text);
                  Constants.prefs.setString(
                      Constants.barcodeResultPrefKey, bloc.state.barcodeResult);
                  bloc.add(AppSignUpSent(
                      barcodeResult: bloc.state.barcodeResult,
                      username: _usernameController.text,
                      password: _passwordController.text,));
                },
                color: Colors.cyan,
                child: Text("Sign Up"),
                textColor: Colors.white,
              )
            ],
          ),
        ),
      ),
    );
  }
}
