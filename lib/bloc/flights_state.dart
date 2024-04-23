import 'package:equatable/equatable.dart';
import 'package:planeapp/data/model/flight_offer.dart';

sealed class FlightsBlocState extends Equatable {
  const FlightsBlocState();

  @override
  List<Object> get props => [];
}

final class FlightsBlocInitial extends FlightsBlocState {}

final class FlightsBlocLoading extends FlightsBlocState {}

final class FlightsBlocFailure extends FlightsBlocState {}

final class FlightsBlocSuccess extends FlightsBlocState {
  final FlightOffer flightOffer;

  const FlightsBlocSuccess(this.flightOffer);

  @override
  List<Object> get props => [flightOffer];
}
