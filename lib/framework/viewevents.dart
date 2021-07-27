import 'bloc.dart';

abstract class ViewEvents<B extends Bloc> {

  final B bloc;

  ViewEvents(this.bloc);


}