import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:nymble_pet_app/blocs/pet_bloc/pet_bloc.dart';
import 'package:nymble_pet_app/pet_data.dart';

void main() {
  group('petBloc', () {
    blocTest('emits petLoadingState and petLoadedState in order.',
        build: () => PetBloc(),
        act: (bloc) => bloc.add(PetLoadingFromDataEvent()),
        expect: () => [PetLoadingState(), PetLoadedState(pets: petList)]);
  });
}
