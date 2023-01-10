import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nymble_pet_app/blocs/adopt_button_bloc/adopt_button_bloc.dart';
import 'package:nymble_pet_app/blocs/fav_button_bloc/fav_button_bloc.dart';
import 'package:nymble_pet_app/components/custom_button.dart';
import 'package:nymble_pet_app/constants.dart';

class Details extends StatelessWidget {
  final Map pet;
  final int index;
  const Details({required this.pet, required this.index, super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: adoptButton(size),
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Stack(
          children: [
            GestureDetector(
              onTap: () {
                showImageModal(context, pet['imagePath']);
              },
              child: Hero(
                tag: 'petImage${pet['id']}',
                child: Image.asset(
                  '${pet['imagePath']}',
                  height: size.height / 2,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.arrow_back,
                      color: Theme.of(context).primaryColor,
                    )),
              ),
            ),
            Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                    height: size.height / 2,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Theme.of(context).scaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${pet['name']}',
                                  style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 20),
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
                            BlocBuilder<FavButtonBloc, FavButtonState>(
                              builder: (context, state) {
                                return IconButton(
                                    onPressed: () {
                                      if (state is FavButtonDisabledState) {
                                        context.read<FavButtonBloc>().add(
                                            FavButtonSelectingEvent(
                                                id: pet['id']));
                                      }
                                      if (state is FavButtonActiveState) {
                                        context.read<FavButtonBloc>().add(
                                            FavButtonRemovingEvent(
                                                id: pet['id']));
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
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            minorDetailContainer(
                                size, context, 'sex', 'Sex', Colors.green),
                            minorDetailContainer(
                                size, context, 'age', 'Age', Colors.blue),
                            minorDetailContainer(
                                size, context, 'price', 'Price', Colors.pink),
                          ],
                        ),
                        SizedBox(
                          height: size.width / 6,
                        )
                      ],
                    ))),
          ],
        ),
      )),
    );
  }

  BlocBuilder<AdoptButtonBloc, AdoptButtonState> adoptButton(Size size) {
    return BlocBuilder<AdoptButtonBloc, AdoptButtonState>(
      builder: (context, state) {
        return CustomButton(
            title: state is AdoptButtonDisabledState ? 'Adopted' : 'Adopt Me',
            width: size.width / 1.1,
            height: size.width / 6,
            disabled: state is AdoptButtonLoadingState ||
                    state is AdoptButtonDisabledState
                ? true
                : false,
            onPressed: () {
              context
                  .read<AdoptButtonBloc>()
                  .add(AdoptButtonAdoptingEvent(id: pet['id']));
              showAdoptionModal(context, size);
            });
      },
    );
  }

  Container minorDetailContainer(Size size, BuildContext context,
      String attribute, String attributeName, Color color) {
    return Container(
      height: size.width / 5,
      width: size.width / 4,
      decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                color: Theme.of(context).shadowColor,
                offset: const Offset(0, 3))
          ]),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            attribute == 'price'
                ? '\u20B9 ${pet[attribute]}'
                : attribute == 'age'
                    ? '${pet[attribute]} years'
                    : '${pet[attribute]}',
            style: TextStyle(fontWeight: FontWeight.w700, color: color),
          ),
          Text(
            attributeName,
            style: const TextStyle(
                fontWeight: FontWeight.w500, color: secondaryTextColor),
          )
        ],
      ),
    );
  }

  showAdoptionModal(context, Size size) {
    showDialog(
        context: context,
        builder: (context) {
          return Container(
            height: size.height,
            width: size.width,
            color: Colors.transparent,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height: size.height / 2,
                    width: size.width,
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text(
                          'Congratulations!',
                          style: TextStyle(
                              fontSize: 30, fontWeight: FontWeight.w700),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            '${pet['name']} is now your pet. Take good care of ${pet['sex'] == 'Male' ? 'him.' : 'her.'}',
                            textAlign: TextAlign.center,
                            style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.w500,
                                color: secondaryTextColor)),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomButton(
                            title: 'Done',
                            width: size.width / 4,
                            height: size.width / 8,
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            disabled: false)
                      ],
                    ),
                  ),
                ),
                Align(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/images/lottie_confetti.json',
                        height: size.width / 1.5, width: size.width / 1.5)),
                Align(
                    alignment: Alignment.center,
                    child: Lottie.asset('assets/images/lottie_pet_adopted.json',
                        height: size.width / 2, width: size.width / 2)),
              ],
            ),
          );
        });
  }

  showImageModal(context, String imagePath) {
    return showDialog(
        barrierColor: Colors.black.withOpacity(0.9),
        context: context,
        builder: (context) {
          return InteractiveViewer(
              child: Stack(
            children: [
              Align(alignment: Alignment.center, child: Image.asset(imagePath)),
              Padding(
                padding: const EdgeInsets.all(10),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                      backgroundColor: Colors.white,
                      child: Icon(
                        Icons.arrow_back,
                        color: Theme.of(context).primaryColor,
                      )),
                ),
              ),
            ],
          ));
        });
  }
}
