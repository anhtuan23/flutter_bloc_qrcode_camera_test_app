part of 'appbloc_bloc.dart';

abstract class AppblocState extends Equatable {
  const AppblocState();
}

class AppblocInitial extends AppblocState {
  @override
  List<Object> get props => [];
}
