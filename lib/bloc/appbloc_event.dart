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

class CameraRequestSent extends AppBlocEvent {
  final String barcodeResult;
  final String username;
  final String password;
  final List<CapturedImage> images;
  const CameraRequestSent({
    @required this.barcodeResult,
    @required this.username,
    @required this.password,
    @required this.images,
  });
}

class PictureCaptured extends AppBlocEvent {
  final String barcodeResult;
  final String username;
  final String password;
  final List<CapturedImage> images;
  const PictureCaptured({
    @required this.barcodeResult,
    @required this.username,
    @required this.password,
    @required this.images,
  });
}

class ImageDeleted extends AppBlocEvent {
  final AppBlocSignedUp state;
  final int deleteIndex;
  ImageDeleted({
    @required this.state,
    @required this.deleteIndex,
  });
}
