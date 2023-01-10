part of 'fav_button_bloc.dart';

abstract class FavButtonEvent extends Equatable {
  const FavButtonEvent();

  @override
  List<Object> get props => [];
}

class FavButtonLoadingEvent extends FavButtonEvent {
  final int id;
  const FavButtonLoadingEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FavButtonSelectingEvent extends FavButtonEvent {
  final int id;
  const FavButtonSelectingEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class FavButtonRemovingEvent extends FavButtonEvent {
  final int id;
  const FavButtonRemovingEvent({required this.id});

  @override
  List<Object> get props => [id];
}
