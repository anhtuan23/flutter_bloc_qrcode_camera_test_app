part of 'appbloc.dart';

@immutable
abstract class AppBlocState {
  final String barcodeResult;
  final String message;
  final bool barcodeScanned;
  final String username;
  final String password;
  final List<String> imagePaths;

  const AppBlocState({
    this.barcodeResult,
    this.message,
    this.barcodeScanned,
    this.username,
    this.password,
    this.imagePaths,
  });
}

class AppBlocSignedUp extends AppBlocState {
  const AppBlocSignedUp({
    @required String barcodeResult,
    @required String username,
    @required String password,
    @required List<String> imagePaths,
  }) : super(
          barcodeResult: barcodeResult,
          username: username,
          password: password,
          imagePaths: imagePaths,
        );
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

class AppBlocTakingPicture extends AppBlocState {
  const AppBlocTakingPicture({
    @required String barcodeResult,
    @required String username,
    @required String password,
    @required List<String> imagePaths,
  }) : super(
          barcodeResult: barcodeResult,
          username: username,
          password: password,
          imagePaths: imagePaths,
        );
}
