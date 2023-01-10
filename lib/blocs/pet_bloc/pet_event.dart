part of 'pet_bloc.dart';

abstract class PetEvent extends Equatable {
  const PetEvent();

  @override
  List<Object> get props => [];
}

class PetLoadingFromDataEvent extends PetEvent {}

class PetFilteringEvent extends PetEvent {
  final String name;
  const PetFilteringEvent({required this.name});
  @override
  List<Object> get props => [name];
}

class AdoptedPetLoadingEvent extends PetEvent {}

class FavouritePetLoadingEvent extends PetEvent {}
