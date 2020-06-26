import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppBloc extends Bloc<AppBlocEvents, AppBlocState> {
  @override
  AppBlocState get initialState => AppBlocSignedOut();

  @override
  Stream<AppBlocState> mapEventToState(
    AppBlocEvents event,
  ) async* {
    switch (event) {
      case AppBlocEvents.AppSignUpSent:
        yield AppBlocSignedUp();
        break;
      case AppBlocEvents.AppSignOutSent:
        yield AppBlocSignedOut();
        break;
    }
  }
}
