part of 'appbloc.dart';

@immutable
abstract class AppBlocState {
  final String barCodeResult;
  final String message;
  final bool barcodeScanned;

  const AppBlocState({this.barCodeResult, this.message, this.barcodeScanned});
}

class AppBlocSignedUp extends AppBlocState {}

class AppBlocSignedOut extends AppBlocState {
  const AppBlocSignedOut({String message: 'Please scan Barcode'}) : super(message: message);
}

class AppBlocSigningUp extends AppBlocState {
  const AppBlocSigningUp({@required barCodeResult})
      : super(
            barCodeResult: barCodeResult,
            message: 'Barcode result: $barCodeResult',
            barcodeScanned: true);
}
