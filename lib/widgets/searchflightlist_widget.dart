import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:planeapp/data/model/flight_offer.dart';

class SearchFlightListWidget extends StatelessWidget {
  final List<FlightOffer> flightOffers;

  String getFlagEmoji(String countryCode) {
    if (countryCode.length != 2) {
      throw ArgumentError("Country code must be exactly two characters long.");
    }

    int firstChar = countryCode.codeUnitAt(0) - 0x41 + 0x1F1E6;
    int secondChar = countryCode.codeUnitAt(1) - 0x41 + 0x1F1E6;

    return String.fromCharCode(firstChar) + String.fromCharCode(secondChar);
  }

  String parseDuration(String durationString) {
    durationString = durationString.replaceAll("PT", "");
    int hours = 0;
    int minutes = 0;
    if (durationString.contains("H")) {
      hours = int.parse(durationString.split("H")[0]);
      durationString = durationString.split("H")[1];
    }
    if (durationString.contains("M")) {
      minutes = int.parse(durationString.split("M")[0]);
    }
    // return "${hours}";
    if (minutes == 0) {
      return "${hours}h";
    } else {
      return "$hours:${minutes}h";
    }
  }

  Duration parseDuration1(String durationString) {
    durationString = durationString.replaceAll("PT", "");
    int hours = 0;
    int minutes = 0;
    if (durationString.contains("H")) {
      hours = int.parse(durationString.split("H")[0]);
      durationString = durationString.split("H")[1];
    }
    if (durationString.contains("M")) {
      minutes = int.parse(durationString.split("M")[0]);
    }
    return Duration(hours: hours, minutes: minutes);
  }

  String allDuration(FlightOffer flightOffer) {
    Duration suma = const Duration();
    for (int i = 0; i < flightOffer.itineraries.length; i++) {
      suma += parseDuration1(flightOffer.itineraries[i].duration);
    }
    return '${suma.inHours}h';
    //:${suma.inMinutes.remainder(60)}h';
  }

  const SearchFlightListWidget({super.key, required this.flightOffers});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Results',
          style: TextStyle(
              fontSize: 26, fontWeight: FontWeight.w400, color: Colors.white),
        ),
        backgroundColor: Colors.transparent,
      ),
      backgroundColor: Colors.lightBlue,
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: Stack(
            children: [
              ListView.builder(
                itemCount: flightOffers.length,
                itemBuilder: (BuildContext context, int index) {
                  final flight = flightOffers[index];
                  final itineraries = flight.itineraries;

                  return Card(
                      elevation: 0,
                      color: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      clipBehavior: Clip.antiAlias,
                      margin: const EdgeInsets.all(4),
                      child: ExpansionTile(
                        backgroundColor: Colors.white,
                        childrenPadding: EdgeInsets.zero,
                        title: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Text(
                                    'Time: ${allDuration(flight)}',
                                    style: const TextStyle(
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    '${flight.price.total} ${flight.price.currency}',
                                    style: const TextStyle(
                                        fontSize: 18.0,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.green),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    itineraries.isEmpty
                                        ? 'Direct'
                                        : 'Transfers: ${itineraries.length + 1}',
                                    style: const TextStyle(color: Colors.red),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: itineraries.expand((itinerary) {
                              final segments = itinerary.segments;
                              return segments.map<Widget>((segment) {
                                return ListTile(
                                    title: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                // Text(
                                                //   '${segment.departure.iataCode} - ',
                                                //   style: const TextStyle(
                                                //       fontWeight:
                                                //           FontWeight.bold),
                                                // ),
                                                // const SizedBox(
                                                //   width: 2,
                                                // ),
                                                FutureBuilder<String>(
                                                  future: (getCountryByIata(
                                                      segment
                                                          .departure.iataCode)),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return const Text(
                                                          'Error');
                                                    } else {
                                                      String countryCode =
                                                          snapshot.data ?? '';
                                                      String flagEmoji =
                                                          getFlagEmoji(
                                                              countryCode); // Funkcja do generowania emotki flagi
                                                      return Text(
                                                        flagEmoji,
                                                        style: const TextStyle(
                                                          fontSize:
                                                              24, // Dostosuj wielkość, jeśli jest to konieczne
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                Text(
                                                  segment.departure.iataCode,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                FutureBuilder<String>(
                                                  future: getCountryByIata(
                                                      segment.arrival.iataCode),
                                                  builder:
                                                      (BuildContext context,
                                                          AsyncSnapshot<String>
                                                              snapshot) {
                                                    if (snapshot
                                                            .connectionState ==
                                                        ConnectionState
                                                            .waiting) {
                                                      return const CircularProgressIndicator();
                                                    } else if (snapshot
                                                        .hasError) {
                                                      return const Text(
                                                          'Error');
                                                    } else {
                                                      String countryCode =
                                                          snapshot.data ?? '';
                                                      String flagEmoji =
                                                          getFlagEmoji(
                                                              countryCode);
                                                      return Text(
                                                        flagEmoji,
                                                        style: const TextStyle(
                                                          fontSize: 24,
                                                        ),
                                                      );
                                                    }
                                                  },
                                                ),
                                                Text(
                                                  segment.arrival.iataCode,
                                                  style: const TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                              ],
                                            )
                                          ]),
                                      Center(
                                        child: Text(
                                          '🛫: ${segment.departure.at.replaceAll("T", " ").substring(0, 16)}\n🛬: ${segment.arrival.at.replaceAll("T", " ").substring(0, 16)}',
                                        ),
                                      ),
                                      Center(
                                        child: Text(
                                          'Aircraft: ${segment.aircraft.code} \nDuration: ${parseDuration(segment.duration)} ',
                                        ),
                                      ),
                                    ]));
                              }).toList();
                            }).toList(),
                          ),
                        ],
                      ));
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  static Future<String> getCountryByIata(String iataCode) async {
    String jsonString = await rootBundle.loadString('assets/airports.json');
    List<dynamic> jsonData = json.decode(jsonString);
    for (var data in jsonData) {
      if (data['iata'] == iataCode) {
        return data['iso'];
      }
    }
    return 'Error';
  }
}
