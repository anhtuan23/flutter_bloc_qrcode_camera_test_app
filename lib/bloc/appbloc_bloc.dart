import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppblocBloc extends Bloc<AppblocEvent, AppblocState> {
  @override
  AppblocState get initialState => AppblocInitial();

  @override
  Stream<AppblocState> mapEventToState(
    AppblocEvent event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
