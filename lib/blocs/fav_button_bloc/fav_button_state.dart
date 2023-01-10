part of 'fav_button_bloc.dart';

abstract class FavButtonState extends Equatable {
  const FavButtonState();

  @override
  List<Object> get props => [];
}

class FavButtonLoadingState extends FavButtonState {}

class FavButtonActiveState extends FavButtonState {}

class FavButtonDisabledState extends FavButtonState {}
