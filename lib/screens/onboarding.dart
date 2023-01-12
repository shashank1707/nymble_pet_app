import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import 'package:nymble_pet_app/blocs/pet_bloc/pet_bloc.dart';
import 'package:nymble_pet_app/components/custom_button.dart';
import 'package:nymble_pet_app/constants.dart';
import 'package:nymble_pet_app/screens/home.dart';
import 'package:nymble_pet_app/services/hive_services.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
          child: SizedBox(
        width: size.width,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                children: [
                  Lottie.asset("assets/images/lottie_licking_dog.json"),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Find Your Dream Pet Here',
                    style: TextStyle(fontSize: 35, fontWeight: FontWeight.w700),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text(
                    'Join us and discover the best pet in your location',
                    style: TextStyle(fontSize: 15, color: secondaryTextColor),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              CustomButton(
                key: const Key('get started'),
                  title: 'Get Started',
                  width: size.width / 2,
                  height: size.width / 8,
                  disabled: false,
                  onPressed: () {
                    final hiveServices = HiveServices();
                    hiveServices.updateFavList(<int>[]);
                    hiveServices.updateAdoptedList(<int>[]);
                    hiveServices.updateAppData(true);
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const Home()));
                  })
            ],
          ),
        ),
      )),
    );
  }
}
