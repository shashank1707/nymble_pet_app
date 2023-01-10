import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nymble_pet_app/blocs/pet_bloc/pet_bloc.dart';
import 'package:nymble_pet_app/screens/home.dart';
import 'package:nymble_pet_app/screens/onboarding.dart';
import 'package:nymble_pet_app/services/hive_services.dart';

class Splash extends StatefulWidget {
  const Splash({super.key});

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    final hiveServices = HiveServices();
    bool appLaunched = hiveServices.getAppData();
    Future.delayed(const Duration(seconds: 2)).then((_) {
      if (appLaunched) {
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => BlocProvider(
                      create: (context) =>
                          PetBloc()..add(PetLoadingFromDataEvent()),
                      child: const Home(),
                    )));
      } else {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const Onboarding()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Lottie.asset('assets/images/lottie_paw.json', repeat: false),
      ),
    );
  }
}
