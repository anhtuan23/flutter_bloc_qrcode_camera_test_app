part of 'appbloc.dart';

@immutable
abstract class AppBlocState {
  final String barcodeResult;
  final String message;
  final bool barcodeScanned;
  final String username;
  final String password;

  const AppBlocState(
      {this.barcodeResult,
      this.message,
      this.barcodeScanned,
      this.username,
      this.password});
}

class AppBlocSignedUp extends AppBlocState {
  const AppBlocSignedUp(
      {@required String barcodeResult,
      @required String username,
      @required String password})
      : super(
            barcodeResult: barcodeResult,
            username: username,
            password: password);
}

class AppBlocSignedOut extends AppBlocState {
  const AppBlocSignedOut({String message: 'Please scan Barcode'})
      : super(message: message);
}

class AppBlocSigningUp extends AppBlocState {
  const AppBlocSigningUp({@required barcodeResult})
      : super(
            barcodeResult: barcodeResult,
            message: 'Barcode result: $barcodeResult',
            barcodeScanned: true);
}

class AppBlocTakingPicture extends AppBlocState{
  const AppBlocTakingPicture(): super();
}