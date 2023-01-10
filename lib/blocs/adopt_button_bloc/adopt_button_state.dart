part of 'adopt_button_bloc.dart';

abstract class AdoptButtonState extends Equatable {
  const AdoptButtonState();

  @override
  List<Object> get props => [];
}

class AdoptButtonLoadingState extends AdoptButtonState {}

class AdoptButtonActiveState extends AdoptButtonState {}

class AdoptButtonDisabledState extends AdoptButtonState {}
