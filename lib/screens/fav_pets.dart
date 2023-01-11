import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_pet_app/blocs/adopt_button_bloc/adopt_button_bloc.dart';
import 'package:nymble_pet_app/blocs/fav_button_bloc/fav_button_bloc.dart';
import 'package:nymble_pet_app/blocs/pet_bloc/pet_bloc.dart';
import 'package:nymble_pet_app/components/dancing_cat.dart';
import 'package:nymble_pet_app/components/loading.dart';
import 'package:nymble_pet_app/components/no_results.dart';
import 'package:nymble_pet_app/components/pet_card.dart';

class FavPets extends StatelessWidget {
  const FavPets({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 0,
        leading: null,
        title: Padding(
          padding: const EdgeInsets.only(left: 10.0),
          child: Text(
            'Favourite Pets',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
        actions: const [DancingCat()],
      ),
      body: SizedBox(
        width: size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: BlocBuilder<PetBloc, PetState>(
                builder: (context, state) {
                  if (state is PetLoadingState) {
                    return const Loading();
                  }

                  if (state is PetLoadedState) {
                    return state.pets.isNotEmpty
                        ? petList(state, size)
                        : NoResults(size: size);
                  }

                  return const Loading();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView petList(PetLoadedState state, Size size) {
    return ListView.builder(
      itemCount: state.pets.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        final pet = state.pets[index];
        return MultiBlocProvider(
            providers: [
              BlocProvider(
                create: (context) => AdoptButtonBloc()
                  ..add(AdoptButtonLoadingEvent(id: pet['id'])),
              ),
              BlocProvider(
                create: (context) =>
                    FavButtonBloc()..add(FavButtonLoadingEvent(id: pet['id'])),
              )
            ],
            child: PetCard(
              pet: pet,
              size: size,
              index: index,
            ));
      },
    );
  }
}
