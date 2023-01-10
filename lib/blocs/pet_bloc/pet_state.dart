part of 'pet_bloc.dart';

abstract class PetState extends Equatable {
  const PetState();

  @override
  List<Object> get props => [];
}

class PetLoadingState extends PetState {}

class PetLoadedState extends PetState {
  final List<Map<dynamic, dynamic>> pets;
  const PetLoadedState({required this.pets});

  @override
  List<Object> get props => [pets];
}
