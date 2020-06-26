part of 'appbloc.dart';

abstract class AppBlocEvent {
  const AppBlocEvent();
}

class AppSignUpSent extends AppBlocEvent {
  final String barcodeResult;
  final String username;
  final String password;
  const AppSignUpSent(
      {@required this.barcodeResult,
      @required this.username,
      @required this.password});
}

class AppSignOutSent extends AppBlocEvent {}

class AppBarcodeResultReceived extends AppBlocEvent {
  final String barcodeResult;
  AppBarcodeResultReceived(this.barcodeResult) : super();
}

class AppBarcodeResultErrorReceived extends AppBlocEvent {}
