import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'appbloc_event.dart';
part 'appbloc_state.dart';

class AppblocBloc extends Bloc<AppBlocEvents, AppblocState> {
  @override
  AppblocState get initialState => AppblocInitial();

  @override
  Stream<AppblocState> mapEventToState(
    AppBlocEvents event,
  ) async* {
    // TODO: implement mapEventToState
  }
}
