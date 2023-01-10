import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nymble_pet_app/services/hive_services.dart';

part 'adopt_button_event.dart';
part 'adopt_button_state.dart';

class AdoptButtonBloc extends Bloc<AdoptButtonEvent, AdoptButtonState> {
  AdoptButtonBloc() : super(AdoptButtonLoadingState()) {
    on<AdoptButtonLoadingEvent>((event, emit) {
      final hiveServices = HiveServices();
      final List<int> adoptedList = hiveServices.getAdoptedList();
      if (adoptedList.contains(event.id)) {
        emit(AdoptButtonDisabledState());
      } else {
        emit(AdoptButtonActiveState());
      }
    });

    on<AdoptButtonAdoptingEvent>((event, emit) {
      final hiveServices = HiveServices();
      final List<int> adoptedList = hiveServices.getAdoptedList();
      adoptedList.add(event.id);
      hiveServices.updateAdoptedList(adoptedList);
      emit(AdoptButtonDisabledState());
    });
  }
}
