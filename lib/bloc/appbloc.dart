import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:meta/meta.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  @override
  AppBlocState get initialState {
    if (Constants.prefs.getBool(Constants.loggedInPrefKey) == true) {
      var barcodeResult =
          Constants.prefs.getString(Constants.barcodeResultPrefKey);
      var username = Constants.prefs.getString(Constants.usernamePrefKey);
      var password = Constants.prefs.getString(Constants.passwordPrefKey);
      return AppBlocSignedUp(
          barcodeResult: barcodeResult,
          username: username,
          password: password,
          imagePaths: []);
    } else {
      return AppBlocSignedOut();
    }
  }

  @override
  Stream<AppBlocState> mapEventToState(
    AppBlocEvent event,
  ) async* {
    if (event is AppSignUpSent) {
      yield AppBlocSignedUp(
          barcodeResult: event.barcodeResult,
          username: event.username,
          password: event.password,
          imagePaths: []);
    } else if (event is AppSignOutSent) {
      yield AppBlocSignedOut();
    } else if (event is AppBarcodeResultReceived) {
      yield AppBlocSigningUp(barcodeResult: event.barcodeResult);
    } else if (event is AppBarcodeResultErrorReceived) {
      yield AppBlocSignedOut(message: "Barcode scanning error");
    } else if (event is CameraRequestSent) {
      yield AppBlocTakingPicture(
        username: event.username,
        password: event.password,
        barcodeResult: event.barcodeResult,
        imagePaths: event.imagePaths,
      );
    } else if (event is PictureCaptured) {
      yield AppBlocSignedUp(
        username: event.username,
        password: event.password,
        barcodeResult: event.barcodeResult,
        imagePaths: event.imagePaths,
      );
    }
  }
}
