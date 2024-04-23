import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planeapp/bloc/flights_bloc.dart';
import 'package:planeapp/widgets/search_widget.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => FlightsBloc(),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            iconTheme: const IconThemeData(color: Colors.white),
            title: Text(
                DateTime.now().hour < 12
                    ? 'Good Morning'
                    : DateTime.now().hour < 18
                        ? 'Good Afternoon'
                        : 'Good Night',
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold)),
          ),
          backgroundColor: Colors.black,
          body: Padding(
            padding:
                const EdgeInsets.fromLTRB(40, 1.2 * kToolbarHeight, 40, 20),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Stack(
                children: [
                  Align(
                    alignment: const AlignmentDirectional(2, -0.1),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          color: Colors.lightBlue, shape: BoxShape.rectangle),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-2, -0.1),
                    child: Container(
                      height: 250,
                      width: 250,
                      decoration: const BoxDecoration(
                          color: Colors.lightBlue, shape: BoxShape.rectangle),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(3, -1.5),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.rectangle),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, -1.5),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.blue, shape: BoxShape.rectangle),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(-3, 1),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.lightBlue, shape: BoxShape.rectangle),
                    ),
                  ),
                  Align(
                    alignment: const AlignmentDirectional(3, 1),
                    child: Container(
                      height: 300,
                      width: 300,
                      decoration: const BoxDecoration(
                          color: Colors.lightBlue, shape: BoxShape.rectangle),
                    ),
                  ),
                  BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 100.0, sigmaY: 100.0),
                    child: Container(
                      decoration:
                          const BoxDecoration(color: Colors.transparent),
                    ),
                  ),
                  const SearchWidget(),
                ],
              ),
            ),
          ),
        ));
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Błąd"),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("OK"),
            ),
          ],
        );
      },
    );
  }
}
