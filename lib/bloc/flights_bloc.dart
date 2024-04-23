import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:planeapp/bloc/flights_event.dart';
import 'package:planeapp/bloc/flights_state.dart';
import 'package:planeapp/data/core/plane_client.dart';
import 'package:planeapp/data/model/flight_offer.dart';

class FlightsBloc extends Bloc<FlightsBlocEvent, FlightsBlocState> {
  FlightsBloc() : super(FlightsBlocInitial()) {
    on<FetchFligthsOffers>((event, emit) async {
      emit(FlightsBlocLoading());
      try {
        PlaneClient planeClient = PlaneClient();

        List<FlightOffer> flightOffers = (await planeClient.fetchFlightOffers(
            event.departureCode,
            event.arrivalCode,
            event.departureDate,
            event.arrivalDate,
            event.numberOfAdults)) as List<FlightOffer>;

        emit(FlightsBlocSuccess(flightOffers as FlightOffer));
      } catch (e) {
        emit(FlightsBlocFailure());
      }
    });
  }
}
