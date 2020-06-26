import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppBloc extends Bloc<AppBlocEvent, AppBlocState> {
  @override
  AppBlocState get initialState => AppBlocSignedOut();

  @override
  Stream<AppBlocState> mapEventToState(
    AppBlocEvent event,
  ) async* {
    if (event is AppSignUpSent) {
      yield AppBlocSignedUp();
    } else if (event is AppSignOutSent) {
      yield AppBlocSignedOut();
    } else if (event is AppBarcodeResultReceived){
      yield AppBlocSigningUp(barcodeResult: event.barcodeResult);
    } else if (event is AppBarcodeResultErrorReceived){
      yield AppBlocSignedOut(message: "Barcode scanning error");
    }
  }
}
