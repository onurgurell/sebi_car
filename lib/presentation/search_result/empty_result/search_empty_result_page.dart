import 'package:flutter/material.dart';

class SearchEmptyResultPage extends StatelessWidget {
  const SearchEmptyResultPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('sonuç bulunamadı'),
    );
  }
}
