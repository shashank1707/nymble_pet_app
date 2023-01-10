part of 'adopt_button_bloc.dart';

abstract class AdoptButtonEvent extends Equatable {
  const AdoptButtonEvent();

  @override
  List<Object> get props => [];
}

class AdoptButtonLoadingEvent extends AdoptButtonEvent {
  final int id;
  const AdoptButtonLoadingEvent({required this.id});

  @override
  List<Object> get props => [id];
}

class AdoptButtonAdoptingEvent extends AdoptButtonEvent {
  final int id;
  const AdoptButtonAdoptingEvent({required this.id});

  @override
  List<Object> get props => [id];
}
