part of 'korzinka_bloc.dart';

@immutable
abstract class KorzinkaEvent {}

class KorzinkaInitEvent extends KorzinkaEvent {}

class KorzinkaNextEvent extends KorzinkaEvent {}

class KorzinkaSearchEvent extends KorzinkaEvent {
  final String text;

  KorzinkaSearchEvent(this.text);
}
