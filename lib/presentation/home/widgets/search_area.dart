import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/home/widgets/search_text_field.dart';
import 'package:sebi_car/view_model/home/home_view_model.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class SearchArea extends StatelessWidget {
  const SearchArea({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<LoginViewModel>(
      builder: (context, viewModel, _) {
        final formattedDate =
            DateFormat('dd/MM/yy').format(viewModel.selectedDate).toString();
        return Positioned(
          bottom: 0,
          child: Container(
            width: context.getDynmaicWidth(1),
            height: context.getDynmaicHeight(.28),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(22),
              gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: [
                  Theme.of(context).colorScheme.inversePrimary,
                  Colors.blue.shade300,
                ],
              ),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SearchBaseTextField(
                  hintText: 'Nereden',
                  controller: viewModel.fromWhereController,
                ),
                SearchBaseTextField(
                  hintText: 'Nereye',
                  controller: viewModel.toWhereController,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    InkWell(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2100),
                        ).then(
                          (selecetdDate) {
                            if (selecetdDate != null) {
                              viewModel.selectDate(selecetdDate);
                            }
                          },
                        );
                      },
                      child: const Icon(Icons.calendar_month),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * .2,
                      height: 25,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.black,
                        ),
                      ),
                      child: Center(
                        child: Text(formattedDate.toString()),
                      ),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(context.getDynmaicWidth(.6), 1),
                      ),
                      onPressed: () {
                        viewModel.saveUserPassangerInfo();
                      },
                      child: const Text('Ara'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
