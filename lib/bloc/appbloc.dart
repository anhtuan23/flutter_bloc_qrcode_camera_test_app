import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:bloc_barcode_camera_demo_app/utils/constants.dart';
import 'package:meta/meta.dart';
import 'package:bloc_barcode_camera_demo_app/models/models.dart';

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
      var profileImagePath =
          Constants.prefs.getString(Constants.profileImagePath);
      return AppBlocSignedUp(
          barcodeResult: barcodeResult,
          username: username,
          password: password,
          images: [],
          profileImagePath: profileImagePath);
    } else {
      return AppBlocSignedOut();
    }
  }

  @override
  Stream<AppBlocState> mapEventToState(
    AppBlocEvent event,
  ) async* {
    String profileImagePath =
        Constants.prefs.getString(Constants.profileImagePath);
    if (event is AppSignUpSent) {
      yield AppBlocSignedUp(
        barcodeResult: event.barcodeResult,
        username: event.username,
        password: event.password,
        images: [],
        profileImagePath: profileImagePath,
      );
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
        images: event.images,
      );
    } else if (event is PictureCaptured) {
      yield AppBlocSignedUp(
        username: event.username,
        password: event.password,
        barcodeResult: event.barcodeResult,
        images: event.images,
        profileImagePath: profileImagePath,
      );
    } else if (event is ImageDeleted) {
      List<CapturedImage> newImages = event.state.images
        ..removeAt(event.deleteIndex);
      yield AppBlocSignedUp(
        barcodeResult: event.state.barcodeResult,
        username: event.state.username,
        password: event.state.password,
        images: newImages,
        profileImagePath: profileImagePath,
      );
    } else if (event is ProfileImageSelected) {
      yield AppBlocSignedUp(
        barcodeResult: event.state.barcodeResult,
        username: event.state.username,
        password: event.state.password,
        images: event.state.images,
        profileImagePath: event.profileImagePath,
      );
    }
  }
}
