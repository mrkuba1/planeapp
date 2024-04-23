import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:planeapp/models/airport.dart';

class SearchWithSuggestionsWidget extends StatefulWidget {
  final List<Airport> airportList;
  final Function(Airport) onSuggestionSelectedCallback;

  const SearchWithSuggestionsWidget({
    super.key,
    required this.airportList,
    required this.onSuggestionSelectedCallback,
  });

  @override
  _SearchWithSuggestionsWidgetState createState() =>
      _SearchWithSuggestionsWidgetState();
}

class _SearchWithSuggestionsWidgetState
    extends State<SearchWithSuggestionsWidget> {
  final TextEditingController _typeAheadController = TextEditingController();
  Airport? _selectedAirport;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TypeAheadField<Airport>(
        suggestionsCallback: (search) async {
          final airports = widget.airportList
              .where((airport) =>
                  airport.name.toLowerCase().contains(search.toLowerCase()))
              .toList();
          return airports;
        },
        itemBuilder: (context, Airport suggestion) {
          return ListTile(
            title: Text(suggestion.name),
            subtitle:
                Text('iso: ${suggestion.iso} name: ${suggestion.continent}'),
          );
        },
        onSuggestionSelected: (Airport suggestion) async {
          setState(() {
            _selectedAirport = suggestion;
            _typeAheadController.text =
                '${_selectedAirport?.name ?? ''} (Id: ${_selectedAirport?.iso}, SmallId: ${_selectedAirport?.continent})';
          });

          widget.onSuggestionSelectedCallback(_selectedAirport!);
        },
        noItemsFoundBuilder: (context) {
          return const ListTile(
            title: Text('No airports found'),
          );
        },
        textFieldConfiguration: TextFieldConfiguration(
          controller: _typeAheadController,
          decoration: const InputDecoration(
            labelText: 'Search Airport',
          ),
        ),
      ),
    );
  }
}
