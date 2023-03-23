// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class SearchAppBar extends StatefulWidget {
  const SearchAppBar(
      {super.key,
      required this.title,
      required this.searchTerms,
      this.searchValue});
  final List<String> searchTerms;
  final searchValue;
  final title;

  @override
  State<SearchAppBar> createState() => _SearchAppBar();
}

class _SearchAppBar extends State<SearchAppBar> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        widget.title,
        style: const TextStyle(),
      ),
      actions: [
        IconButton(
            onPressed: () {
              showSearch(
                context: context,
                delegate: CustomSearchDelegate(
                    widget.searchTerms, widget.searchValue),
              );
            },
            icon: Icon(
              BootstrapIcons.search,
              color: ColorScheme.fromSwatch().secondary,
            )),
      ],
    );
  }
}

class CustomSearchDelegate extends SearchDelegate {
  CustomSearchDelegate(this.searchTerms, this.searchValue);

  final List<String> searchTerms;
  var searchValue;

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(BootstrapIcons.x),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(BootstrapIcons.back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    List<String> matchQuery = [];
    for (searchValue in searchTerms) {
      if (searchValue.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(searchValue);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<String> matchQuery = [];
    for (searchValue in searchTerms) {
      if (searchValue.toLowerCase().contains(query.toLowerCase())) {
        matchQuery.add(searchValue);
      }
    }
    return ListView.builder(
        itemCount: matchQuery.length,
        itemBuilder: (context, index) {
          var result = matchQuery[index];
          return ListTile(
            title: Text(result),
          );
        });
  }
}
