import 'package:flutter/material.dart';
import 'package:sebi_car/presentation/home/widgets/home_text.dart';
import 'package:sebi_car/presentation/home/widgets/image_and_search_area.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text('Sebi Car'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(
          Icons.add,
        ),
      ),
      body: const SingleChildScrollView(
        child: Column(
          children: [
            HomeText(),
            HomeImageAndSearch(),
          ],
        ),
      ),
    );
  }
}
