import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';

class CustomSearchDelegate extends SearchDelegate {
  final DataFromJsonBloc _searchBloc;
  CustomSearchDelegate(this._searchBloc);

  @override
  ThemeData appBarTheme(BuildContext context) {
    return Theme.of(context).copyWith(
      useMaterial3: true,
      primaryColor: Colors.red,
    );
  }

  // Demo list to show querying
  late List<String> data;
  List<String> searchHistory = [
    "Arad",
    "Petrosani",
    "Timisoara",
    "Budapest",
    "Iasi"
  ];

// clear the input text
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
        icon: const Icon(Icons.clear),
      ),
    ];
  }

// pop out the search menu
  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      tooltip: 'Back',
      icon: AnimatedIcon(
        icon: AnimatedIcons.menu_arrow,
        progress: transitionAnimation,
      ),
      onPressed: () {
        close(context, "");
      },
    );
  }

// build the show query
  @override
  Widget buildResults(BuildContext context) {
    _searchBloc.add(GetListFromJson(query));
    try {
      _searchBloc.add(GetListFromJson(query));
    } catch (err) {
      return Text(err.toString());
    }

    return BlocBuilder<DataFromJsonBloc, DataFromJsonState>(
        bloc: _searchBloc,
        builder: (BuildContext context, DataFromJsonState state) {
          if (state is DataFromJsonEror) {
            return const Text('No city provided!');
          }

          if (state is DataFromJsonLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state is DataFromJsonEror) {
            return const Center(
              child: Text('No city provided!'),
            );
          }

          if (state is DataFromJsonLoaded) {
            return ListTile(
              leading: const Icon(Icons.location_city),
              title: Text(query, maxLines: 1, overflow: TextOverflow.ellipsis),
              dense: true,
              onTap: () {
                close(context, query);
              },
            );
          }

          return Container();
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (var cities in searchHistory) {
      if (cities.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(cities);
      }
    }
    return ListView.builder(
      itemCount: matchQuery.length,
      itemBuilder: ((context, index) {
        var result = matchQuery[index];
        return GestureDetector(
          onTap: () {
            query = result;
            close(context, result);
            showResults(context);
          },
          child: ListTile(
            leading: const Icon(Icons.location_city),
            title: Text(result),
          ),
        );
      }),
    );
  }
}
