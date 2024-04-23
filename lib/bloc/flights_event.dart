import 'package:equatable/equatable.dart';

abstract class FlightsBlocEvent extends Equatable {
  const FlightsBlocEvent();

  @override
  List<Object> get props => [];
}

class FetchFligthsOffers extends FlightsBlocEvent {
  final String departureCode;
  final String arrivalCode;
  final String departureDate;
  final String arrivalDate;
  final String numberOfAdults;

  const FetchFligthsOffers(this.departureCode, this.arrivalCode,
      this.departureDate, this.arrivalDate, this.numberOfAdults);

  @override
  List<Object> get props =>
      [departureCode, arrivalCode, departureDate, arrivalDate, numberOfAdults];
}
