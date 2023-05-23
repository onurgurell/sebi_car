import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/search_result/empty_result/search_empty_result_page.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class SearchResult extends StatelessWidget {
  const SearchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Result'),
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          return viewModel.searchResult.isEmpty
              ? const SearchEmptyResultPage()
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  itemCount: viewModel.searchResult.length,
                  itemBuilder: (context, index) {
                    final driverInfo = viewModel.searchResult[index];
                    return Column(
                      children: [
                        Container(
                            width: context.getDynmaicWidth(.9),
                            height: context.getDynmaicHeight(.2),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      SizedBox(
                                        width: context.getDynmaicWidth(.4),
                                        height: context.getDynmaicHeight(.1),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Column(
                                              children: [
                                                const Icon(Icons.alarm),
                                                const SizedBox(height: 5),
                                                Text(
                                                  driverInfo["selectedTime"]
                                                      .toString(),
                                                )
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Text(
                                                  driverInfo["fromWhere"]
                                                      .toString()
                                                      .toUpperCase(),
                                                ),
                                                const Icon(
                                                    Icons.arrow_downward),
                                                Text(
                                                  driverInfo["toWhere"]
                                                      .toString()
                                                      .toUpperCase(),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding:
                                            const EdgeInsets.only(right: 12),
                                        width: context.getDynmaicWidth(.2),
                                        height: context.getDynmaicHeight(.1),
                                        child: Text(
                                          "${driverInfo["price"].toString()} TL",
                                          style: const TextStyle(fontSize: 15),
                                          textAlign: TextAlign.end,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            )),
                        const SizedBox(height: 12),
                      ],
                    );
                  },
                );
        },
      ),
    );
  }
}
