import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:nymble_pet_app/blocs/pet_bloc/pet_bloc.dart';
import 'package:nymble_pet_app/constants.dart';
import 'package:nymble_pet_app/screens/adopted_pets.dart';
import 'package:nymble_pet_app/screens/fav_pets.dart';
import 'package:nymble_pet_app/screens/pets.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  int navigationIndex = 0;
  late TabController tabController;

  // list of screens
  List<Widget> screens = [
    BlocProvider(
      create: (context) => PetBloc()..add(PetLoadingFromDataEvent()),
      child: const Pets(),
    ),
    BlocProvider(
      create: (context) => PetBloc()..add(FavouritePetLoadingEvent()),
      child: const FavPets(),
    ),
    BlocProvider(
      create: (context) => PetBloc()..add(AdoptedPetLoadingEvent()),
      child: const AdoptedPets(),
    ),
  ];

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this, initialIndex: 0);
    super.initState();
  }

  @override
  void dispose() {
    Hive.box(petBoxKey).close();
    Hive.box(appBoxKey).close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      bottomNavigationBar: Padding(
        padding: EdgeInsets.symmetric(horizontal: width / 8),
        child: SalomonBottomBar(
            currentIndex: navigationIndex,
            onTap: (index) {
              setState(() {
                navigationIndex = index;
                tabController.index = index;
              });
            },
            items: [
              SalomonBottomBarItem(
                icon: const Icon(Icons.pets),
                title: const Text("Pets"),
                selectedColor: Theme.of(context).primaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.favorite),
                title: const Text("Favourites"),
                selectedColor: Theme.of(context).primaryColor,
              ),
              SalomonBottomBarItem(
                icon: const Icon(Icons.history),
                title: const Text("Adopted"),
                selectedColor: Theme.of(context).primaryColor,
              ),
            ]),
      ),
      body: TabBarView(
        controller: tabController,
        physics: const NeverScrollableScrollPhysics(),
        children: screens,
      ),
    );
  }
}
