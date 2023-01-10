import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:nymble_pet_app/services/hive_services.dart';

part 'fav_button_event.dart';
part 'fav_button_state.dart';

class FavButtonBloc extends Bloc<FavButtonEvent, FavButtonState> {
  FavButtonBloc() : super(FavButtonLoadingState()) {
    on<FavButtonLoadingEvent>((event, emit) {
      final hiveServices = HiveServices();
      final List<int> favList = hiveServices.getFavList();
      if (favList.contains(event.id)) {
        emit(FavButtonActiveState());
      } else {
        emit(FavButtonDisabledState());
      }
    });

    on<FavButtonSelectingEvent>((event, emit) {
      final hiveServices = HiveServices();
      final List<int> favList = hiveServices.getFavList();
      favList.add(event.id);
      hiveServices.updateFavList(favList);
      emit(FavButtonActiveState());
    });

    on<FavButtonRemovingEvent>((event, emit) {
      final hiveServices = HiveServices();
      final List<int> favList = hiveServices.getFavList();
      favList.remove(event.id);
      hiveServices.updateFavList(favList);
      emit(FavButtonDisabledState());
    });
  }
}
