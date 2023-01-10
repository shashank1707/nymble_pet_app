import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nymble_pet_app/pet_data.dart';
import 'package:nymble_pet_app/services/hive_services.dart';

part 'pet_event.dart';
part 'pet_state.dart';

class PetBloc extends Bloc<PetEvent, PetState> {
  PetBloc() : super(PetLoadingState()) {
    on<PetLoadingFromDataEvent>((event, emit) {
      emit(PetLoadingState());
      final List<Map<dynamic, dynamic>> pets = petList;
      emit(PetLoadedState(pets: pets));
    });

    on<PetFilteringEvent>((event, emit) {
      emit(PetLoadingState());
      List<Map<dynamic, dynamic>> pets = petList
          .where((element) =>
              element['name']
                  .toLowerCase()
                  .contains(event.name.toLowerCase()) ||
              element['type'].toLowerCase().contains(event.name.toLowerCase()))
          .toList();
      emit(PetLoadedState(pets: pets));
    });

    on<AdoptedPetLoadingEvent>((event, emit) {
      emit(PetLoadingState());
      final hiveServices = HiveServices();
      List<int> adoptedList = hiveServices.getAdoptedList();
      List<Map<dynamic, dynamic>> pets =
          petList.where((e) => adoptedList.contains(e['id'])).toList();
      emit(PetLoadedState(pets: pets));
    });

    on<FavouritePetLoadingEvent>((event, emit) {
      emit(PetLoadingState());
      final hiveServices = HiveServices();
      List<int> favList = hiveServices.getFavList();
      List<Map<dynamic, dynamic>> pets =
          petList.where((e) => favList.contains(e['id'])).toList();
      emit(PetLoadedState(pets: pets));
    });
  }
}
