import 'package:flutter/material.dart';
import 'package:sebi_car/presentation/search/empty_result/search_empty_result_page.dart';
import 'package:sebi_car/presentation/search/search_results_page/search_results_page.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({
    super.key,
    required this.searchResult,
  });
  final List<Map<String, dynamic>> searchResult;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: searchResult.isEmpty
          ? const SearchEmptyResultPage()
          : SearchResultPage(searchResult: searchResult),
    );
  }
}
