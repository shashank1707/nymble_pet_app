import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nymble_pet_app/blocs/adopt_button_bloc/adopt_button_bloc.dart';
import 'package:nymble_pet_app/blocs/fav_button_bloc/fav_button_bloc.dart';
import 'package:nymble_pet_app/constants.dart';
import 'package:nymble_pet_app/screens/details.dart';

class PetCard extends StatelessWidget {
  final Map pet;
  final Size size;
  final int index;
  const PetCard(
      {required this.pet, required this.size, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (_) => MultiBlocProvider(
                  providers: [
                    BlocProvider.value(
                        value: BlocProvider.of<FavButtonBloc>(context)),
                    BlocProvider.value(
                        value: BlocProvider.of<AdoptButtonBloc>(context))
                  ],
                  child: Details(
                    pet: pet,
                    index: index,
                  ),
                )));
      },
      child: Container(
        margin: const EdgeInsets.all(20),
        padding: const EdgeInsets.all(5),
        decoration:
            BoxDecoration(borderRadius: BorderRadius.circular(30), boxShadow: [
          BoxShadow(
              blurRadius: 5,
              color: Theme.of(context).shadowColor,
              offset: const Offset(0, 3))
        ]),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Hero(
                tag: 'petImage${pet['id']}',
                child: Image.asset(
                  pet['imagePath'],
                  height: size.width,
                  width: size.width,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                  width: size.width,
                  height: size.width / 3,
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                            blurRadius: 5,
                            color: Theme.of(context).shadowColor,
                            offset: const Offset(0, 3))
                      ]),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${pet['name']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w700, fontSize: 20),
                              ),
                              Text(
                                '${pet['type']}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: secondaryTextColor),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(
                                Icons.watch_later_outlined,
                                color: Theme.of(context).primaryColor,
                                size: 20,
                              ),
                              Text('  ${pet['age']} years'),
                              const SizedBox(
                                width: 20,
                              ),
                              Icon(
                                pet['sex'] == 'Male'
                                    ? Icons.male
                                    : Icons.female,
                                color: pet['sex'] == 'Male'
                                    ? Colors.blue
                                    : Colors.pink,
                              ),
                              Text('  ${pet['sex']}'),
                            ],
                          )
                        ],
                      ),
                      BlocBuilder<FavButtonBloc, FavButtonState>(
                        builder: (context, state) {
                          return IconButton(
                              onPressed: () {
                                if (state is FavButtonDisabledState) {
                                  context.read<FavButtonBloc>().add(
                                      FavButtonSelectingEvent(id: pet['id']));
                                }
                                if (state is FavButtonActiveState) {
                                  context.read<FavButtonBloc>().add(
                                      FavButtonRemovingEvent(id: pet['id']));
                                }
                              },
                              icon: Icon(
                                state is FavButtonLoadingState ||
                                        state is FavButtonDisabledState
                                    ? Icons.favorite_border
                                    : Icons.favorite,
                                color: Theme.of(context).primaryColor,
                              ));
                        },
                      )
                    ],
                  )),
            ),
            Positioned(
              top: 0,
              left: 0,
              child: BlocBuilder<AdoptButtonBloc, AdoptButtonState>(
                builder: (context, state) {
                  return Visibility(
                    visible: state is AdoptButtonDisabledState,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(30)),
                      child: const Text(
                        'Adopted',
                        style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: secondaryTextColor),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
