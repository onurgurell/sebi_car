import 'package:flutter/material.dart';
import 'package:sebi_car/extension/context_extension.dart';

class SearchResultPage extends StatelessWidget {
  const SearchResultPage({
    super.key,
    required this.searchResult,
  });
  final List<Map<String, dynamic>> searchResult;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      itemCount: searchResult.length,
      itemBuilder: (context, index) {
        final driverInfo = searchResult[index];
        return Column(
          children: [
            Container(
              width: context.getDynmaicWidth(.9),
              height: context.getDynmaicHeight(.15),
              decoration: BoxDecoration(
                gradient: LinearGradient(colors: [
                  Theme.of(context).colorScheme.inversePrimary,
                  Colors.blue.shade300,
                ]),
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
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: context.getDynmaicWidth(.4),
                          height: context.getDynmaicHeight(.1),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              Column(
                                children: [
                                  const Icon(Icons.alarm),
                                  const SizedBox(height: 5),
                                  Text(
                                    driverInfo["selectedTime"].toString(),
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
                                  const Icon(Icons.arrow_downward),
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
                          padding: const EdgeInsets.only(right: 12),
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
                    Container(
                      alignment: Alignment.centerLeft,
                      padding: const EdgeInsets.only(right: 12),
                      width: context.getDynmaicWidth(.75),
                      child: Text(
                        driverInfo["name"].toString().toUpperCase(),
                        style: const TextStyle(fontSize: 15),
                        textAlign: TextAlign.end,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 12),
          ],
        );
      },
    );
  }
}
