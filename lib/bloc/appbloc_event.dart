part of 'appbloc.dart';

abstract class AppBlocEvent {
  const AppBlocEvent();
}

class AppSignUpSent extends AppBlocEvent {}

class AppSignOutSent extends AppBlocEvent {}

class AppBarcodeResultReceived extends AppBlocEvent {
  final String barcodeResult;
  AppBarcodeResultReceived(this.barcodeResult) : super();
}

class AppBarcodeResultErrorReceived extends AppBlocEvent{}