import 'dart:html';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testingbloc/bloc/data_from_json_bloc.dart';
import 'package:testingbloc/bloc/searchBloc/search_bloc.dart';
import 'package:testingbloc/constants.dart';
import 'package:testingbloc/home_page.dart';

class CustomSearchDelegate extends SearchDelegate {
  final searchBloc;
  // final cityBloc;
  CustomSearchDelegate(this.searchBloc);

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
        icon: Icon(Icons.clear),
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
    List<String> matchQuery = [];
    for (var cities in searchHistory) {
      if (cities.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(cities);
      }
    }
    return ListTile(
      title: Text(query),
      leading: Icon(Icons.location_city),
      onTap: () {
        close(context, query);
      },
    );
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
          child: Container(
            child: ListTile(
              title: Text(result),
            ),
          ),
        );
      }),
    );
  }

  // final suggestions = query.isEmpty ? searchHistory : query;
  // // : _data.where((int i) => '$i'.startsWith(query));

  // return _SuggestionList(
  //   query: query,
  //   suggestions: searchHistory,
  //   onSelected: (String? suggestion) {
  //     query = suggestion!;
  //     showResults(context);
  //   },
  // );
}

// // Search Page
// import 'package:flutter/material.dart';
// import 'package:testingbloc/constants.dart';

// class SearchPage extends StatelessWidget {
//   const SearchPage({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       extendBodyBehindAppBar: true,
//       appBar: AppBar(
//           iconTheme: IconThemeData(
//             color: kPrimaryColor,
//           ),
//           backgroundColor: Colors.transparent,
//           elevation: 0, //change your color here
//           // The search area here
//           title: Container(
//             width: double.infinity,
//             height: 40,
//             decoration: BoxDecoration(
//                 color: Colors.white, borderRadius: BorderRadius.circular(5)),
//             child: Center(
//               child: TextField(
//                 decoration: InputDecoration(
//                     prefixIcon: Icon(Icons.search, color: kPrimaryColor),
//                     suffixIcon: IconButton(
//                       icon: Icon(Icons.clear, color: kPrimaryColor),
//                       onPressed: () {
//                         /* Clear the search field */
//                       },
//                     ),
//                     hintText: 'Search...',
//                     border: InputBorder.none),
//               ),
//             ),
//           )),
//       body: Container(
//         decoration: const BoxDecoration(
//           image: DecorationImage(
//             fit: BoxFit.fill,
//             image: AssetImage("assets/background.jpg"),
//           ),
//         ),
//       ),
//     );
//   }
// }

class _SuggestionList extends StatelessWidget {
  const _SuggestionList({this.suggestions, this.query, this.onSelected});

  final List<String?>? suggestions;
  final String? query;
  final ValueChanged<String?>? onSelected;

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    return ListView.builder(
      itemCount: suggestions?.length,
      itemBuilder: (BuildContext context, int i) {
        final String? suggestion = suggestions![i];
        return ListTile(
          leading:
              query!.isEmpty ? const Icon(Icons.history) : const Icon(null),
          title: RichText(
            text: TextSpan(
              text: suggestion?.substring(0, query?.length),
              style: theme.textTheme.subtitle2
                  ?.copyWith(fontWeight: FontWeight.bold),
              children: <TextSpan>[
                TextSpan(
                  text: suggestion?.substring(query!.length),
                  style: theme.textTheme.subtitle2,
                ),
              ],
            ),
          ),
          onTap: () {
            onSelected!(suggestion);
          },
        );
      },
    );
  }
}
