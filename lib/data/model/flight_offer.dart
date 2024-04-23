import 'package:planeapp/data/model/itinerary.dart';

class FlightOffer {
  final String type;
  final String id;
  final String source;
  final bool instantTicketingRequired;
  final bool nonHomogeneous;
  final bool oneWay;
  final String lastTicketingDate;
  final String lastTicketingDateTime;
  final int numberOfBookableSeats;
  final List<Itinerary> itineraries;
  final Price price;
  // final PricingOptions pricingOptions;
  // final List<String> validatingAirlineCodes;
  // final List<TravelerPricing> travelerPricings;

  FlightOffer({
    required this.type,
    required this.id,
    required this.source,
    required this.instantTicketingRequired,
    required this.nonHomogeneous,
    required this.oneWay,
    required this.lastTicketingDate,
    required this.lastTicketingDateTime,
    required this.numberOfBookableSeats,
    required this.itineraries,
    required this.price,
    // required this.pricingOptions,
    // required this.validatingAirlineCodes,
    // required this.travelerPricings,
  });

  factory FlightOffer.fromJson(Map<String, dynamic> json) {
    final List<dynamic> itinerariesList = json['itineraries'];
    final List<dynamic> travelerPricingsList = json['travelerPricings'];
    return FlightOffer(
        type: json['type'],
        id: json['id'],
        source: json['source'],
        instantTicketingRequired: json['instantTicketingRequired'],
        nonHomogeneous: json['nonHomogeneous'],
        oneWay: json['oneWay'],
        lastTicketingDate: json['lastTicketingDate'],
        lastTicketingDateTime: json['lastTicketingDateTime'],
        numberOfBookableSeats: json['numberOfBookableSeats'],
        itineraries: itinerariesList
            .map((itineraries) => Itinerary.fromJson(itineraries))
            .toList(),
        price: Price.fromJson(json['price']));
    // pricingOptions: PricingOptions.fromJson(json['pricingOptions']),
    // validatingAirlineCodes:
    //     List<String>.from(json['validatingAirlineCodes']),
    // travelerPricings: travelerPricingsList
    //     .map((travelerPricings) =>
    //         TravelerPricing.fromJson(travelerPricings))
    //     .toList());
  }
  @override
  String toString() {
    return 'FlightOffer { '
        'type: $type, '
        'id: $id, '
        'source: $source, '
        'instantTicketingRequired: $instantTicketingRequired, '
        'nonHomogeneous: $nonHomogeneous, '
        'oneWay: $oneWay, '
        'lastTicketingDate: $lastTicketingDate, '
        'lastTicketingDateTime: $lastTicketingDateTime, '
        'numberOfBookableSeats: $numberOfBookableSeats, '
        'itineraries: $itineraries, '
        'price: $price, '
        // 'pricingOptions: $pricingOptions, '
        // 'validatingAirlineCodes: $validatingAirlineCodes, '
        // 'travelerPricings: $travelerPricings '
        '}';
  }
}

class Price {
  final String currency;
  final String total;
  final String base;
  final List<Fee> fees;
  final String grandTotal;

  Price({
    required this.currency,
    required this.total,
    required this.base,
    required this.fees,
    required this.grandTotal,
  });

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      currency: json['currency'],
      total: json['total'],
      base: json['base'],
      fees: (json['fees'] as List).map((i) => Fee.fromJson(i)).toList(),
      grandTotal: json['grandTotal'],
    );
  }
}

class Fee {
  final String amount;
  final String type;

  Fee({
    required this.amount,
    required this.type,
  });

  factory Fee.fromJson(Map<String, dynamic> json) {
    return Fee(
      amount: json['amount'],
      type: json['type'],
    );
  }
}

class PricingOptions {
  final List<String> fareType;
  final bool includedCheckedBagsOnly;

  PricingOptions({
    required this.fareType,
    required this.includedCheckedBagsOnly,
  });

  factory PricingOptions.fromJson(Map<String, dynamic> json) {
    return PricingOptions(
      fareType: List<String>.from(json['fareType']),
      includedCheckedBagsOnly: json['includedCheckedBagsOnly'],
    );
  }
}

class TravelerPricing {
  final String travelerId;
  final String fareOption;
  final String travelerType;
  final Price price;
  // final List<FareDetailsBySegment> fareDetailsBySegment;

  TravelerPricing({
    required this.travelerId,
    required this.fareOption,
    required this.travelerType,
    required this.price,
    // required this.fareDetailsBySegment,
  });

  factory TravelerPricing.fromJson(Map<String, dynamic> json) {
    return TravelerPricing(
      travelerId: json['travelerId'],
      fareOption: json['fareOption'],
      travelerType: json['travelerType'],
      price: Price.fromJson(json['price']),
      // fareDetailsBySegment: (json['fareDetailsBySegment'] as List)
      //     .map((i) => FareDetailsBySegment.fromJson(i))
      //     .toList(),
    );
  }
}
