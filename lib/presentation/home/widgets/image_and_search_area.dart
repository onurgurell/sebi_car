import 'package:flutter/material.dart';
import 'package:sebi_car/core/constants/app_image_paths.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/home/widgets/home_search_area.dart';

class HomeImageAndSearch extends StatelessWidget {
  const HomeImageAndSearch({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _ImageArea(),
        HomeSearchArea(),
      ],
    );
  }
}

class _ImageArea extends StatelessWidget {
  const _ImageArea();

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      height: context.getDynmaicHeight(.6),
      child: Image.asset(AppImagePaths.homePage),
    );
  }
}
