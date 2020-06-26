import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppblocBloc extends Bloc<AppblocEvents, AppblocState> {
  @override
  AppblocState get initialState => AppblocSignedOut();

  @override
  Stream<AppblocState> mapEventToState(
    AppblocEvents event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
