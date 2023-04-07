// ignore_for_file: prefer_typing_uninitialized_variables, file_names

import 'package:bootstrap_icons/bootstrap_icons.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatefulWidget {
  const SearchBarWidget(
      {super.key,
      required this.controller,
      required this.text,
      required this.onChanged,
      required this.hintText});
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final String text;
  final String hintText;
  @override
  State<SearchBarWidget> createState() => _SearchBarWidgetState();
}

class _SearchBarWidgetState extends State<SearchBarWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 42,
      margin: const EdgeInsets.only(top: 12, left: 16, right: 16, bottom: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: const Color.fromARGB(255, 221, 199, 248),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12),
        child: TextField(
          cursorColor: const Color.fromARGB(255, 51, 0, 67),
          controller: widget.controller,
          decoration: InputDecoration(
            icon: const Icon(BootstrapIcons.search,
                color: Color.fromARGB(255, 51, 0, 67)),
            suffixIcon: widget.text.isNotEmpty
                ? TextButton(
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged('');
                      FocusScope.of(context)
                          .requestFocus(FocusNode(canRequestFocus: true));
                    },
                    child: const Icon(BootstrapIcons.x,
                        color: Color.fromARGB(255, 51, 0, 67)),
                  )
                : null,
            hintText: widget.hintText,
            hintStyle: const TextStyle(
              color: Color.fromARGB(255, 51, 0, 67),
              fontFamily: "Poppins",
              fontSize: 14,
            ),
            border: InputBorder.none,
          ),
          style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "Poppins",
            fontSize: 14,
          ),
          onChanged: widget.onChanged,
        ),
      ),
    );
  }
}

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
