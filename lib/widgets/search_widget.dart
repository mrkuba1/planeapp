import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planeapp/data/core/plane_client.dart';
import 'package:planeapp/models/airport.dart';
import 'package:planeapp/widgets/searchflightlist_widget.dart';

class SearchWidget extends StatefulWidget {
  const SearchWidget({super.key});

  @override
  _SearchWidgetState createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<SearchWidget> {
  final TextEditingController arrivalAirportController =
      TextEditingController();
  final TextEditingController departureAirportController =
      TextEditingController();
  final ValueNotifier<int> adultsValueNotifier = ValueNotifier<int>(0);
  DateTime? _selectedDateDeparture;
  Airport? selectedAirPort;
  DateTime? _selectedDateArrival;
  PlaneClient planeClient = PlaneClient();
  List<Airport> downloadedAirports = [];

  Future<void> fetchAirports() async {
    print("Fetching airport data...");
    try {
      final String contents =
          await rootBundle.loadString('assets/airports.json');
      final List<dynamic> jsonData = json.decode(contents);
      List<Airport> airportList =
          jsonData.map((json) => Airport.fromJson(json)).toList();

      setState(() {
        downloadedAirports = airportList;
      });
    } catch (e) {
      print("Error fetching airport data: $e");
    }
  }

  void swapAirports() {
    String temp = departureAirportController.text;
    departureAirportController.text = arrivalAirportController.text;
    arrivalAirportController.text = temp;
  }

  Future<void> _selectDateDeparture(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != _selectedDateDeparture &&
        picked.isAfter(DateTime.now())) {
      setState(() {
        _selectedDateDeparture = picked;
      });
    }
  }

  Future<void> _selectDateArrival(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );
    if (picked != null &&
        picked != _selectedDateArrival &&
        picked.isAfter(DateTime.now())) {
      setState(() {
        _selectedDateArrival = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Text(
          '✈️ Flight Finder',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        const SizedBox(
          height: 30,
        ),
        Container(
          padding: const EdgeInsets.all(25),
          height: 300,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Departure Airport',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 10),
                        // SearchWithSuggestionsWidget(
                        //   onSuggestionSelectedCallback: (selectedAirPort) {
                        //     setState(() {});
                        //   },
                        //   airportList: downloadedAirports,
                        // ),
                        TextField(
                          controller: departureAirportController,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            hintText: 'Enter departure airport',
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              IconButton(
                onPressed: swapAirports,
                icon: const Icon(Icons.swap_horiz),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Arrival Airport',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: arrivalAirportController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(10))),
                        hintText: 'Enter arrival airport',
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Container(
          padding: const EdgeInsets.all(25),
          height: 205,
          width: 400,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      const Text(
                        "Departure",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () => _selectDateDeparture(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _selectedDateDeparture == null
                                ? "Select Date"
                                : "${_selectedDateDeparture?.day}/${_selectedDateDeparture?.month}/${_selectedDateDeparture?.year}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Column(
                    children: [
                      const Text(
                        "Return",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 16),
                      ),
                      GestureDetector(
                        onTap: () => _selectDateArrival(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Text(
                            _selectedDateArrival == null
                                ? "Select Date"
                                : "${_selectedDateArrival?.day}/${_selectedDateArrival?.month}/${_selectedDateArrival?.year}",
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Adults :',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        const SizedBox(height: 0),
                        ValueListenableBuilder<int>(
                          valueListenable: adultsValueNotifier,
                          builder: (context, value, child) {
                            return Slider(
                              thumbColor: Colors.blue,
                              activeColor: Colors.blue,
                              value: value.toDouble() < 1.0
                                  ? 1.0
                                  : value.toDouble(),
                              min: 1,
                              max: 20,
                              onChanged: (newValue) {
                                adultsValueNotifier.value = newValue.round();
                              },
                              divisions: 20,
                              label: value.toString(),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () async {
              try {
                final flightOffers = await planeClient.fetchFlightOffers(
                    departureAirportController.text,
                    arrivalAirportController.text,
                    adultsValueNotifier.value.toString(),
                    _selectedDateArrival.toString(),
                    _selectedDateDeparture.toString());
                if (flightOffers.isEmpty) {
                  showErrorMessage(context, "No flight offers found");
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SearchFlightListWidget(flightOffers: flightOffers),
                    ),
                  );
                }
              } catch (e) {
                print('Wystąpił błąd: $e');
                showErrorMessage(context, "Error, try again");
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.amber,
              padding: const EdgeInsets.all(15.0),
            ),
            child: const Text('SEARCH',
                style: TextStyle(fontSize: 20, color: Colors.black)),
          ),
        ),
      ],
    );
  }

  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Error"),
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
