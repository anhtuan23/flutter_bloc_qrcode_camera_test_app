part of 'appbloc.dart';

@immutable
abstract class AppBlocState {
  final String barcodeResult;
  final String message;
  final bool barcodeScanned;

  const AppBlocState({this.barcodeResult, this.message, this.barcodeScanned});
}

class AppBlocSignedUp extends AppBlocState {}

class AppBlocSignedOut extends AppBlocState {
  const AppBlocSignedOut({String message: 'Please scan Barcode'}) : super(message: message);
}

class AppBlocSigningUp extends AppBlocState {
  const AppBlocSigningUp({@required barcodeResult})
      : super(
            barcodeResult: barcodeResult,
            message: 'Barcode result: $barcodeResult',
            barcodeScanned: true);
}
