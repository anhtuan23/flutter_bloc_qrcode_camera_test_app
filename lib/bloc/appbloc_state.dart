part of 'appbloc.dart';

@immutable
abstract class AppBlocState {
  final String barCodeResult;
  const AppBlocState({this.barCodeResult : "parent result"});
}

class AppBlocSignedUp extends AppBlocState {}

class AppBlocSignedOut extends AppBlocState {
  const AppBlocSignedOut({String barCodeResult : "signed out result"}) : super(barCodeResult: barCodeResult);

  @override
  String toString() => 'Barcode result: $barCodeResult';
}
