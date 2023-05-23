import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sebi_car/extension/context_extension.dart';
import 'package:sebi_car/presentation/driver_info/widget/base_container_for_driver_info.dart';
import 'package:sebi_car/presentation/driver_info/widget/base_select_time_or_calender.dart';
import 'package:sebi_car/view_model/login/login_view_model.dart';

class JourneyCreationView extends StatelessWidget {
  const JourneyCreationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: context.getDynmaicWidth(1),
            child: const Text(
              "Yolculuk Oluştur",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),
          ),
        ],
      ),
      body: Consumer<LoginViewModel>(
        builder: (context, viewModel, _) {
          final formattedDate = DateFormat('dd/MM/yy')
              .format(viewModel.driverSelectedCal)
              .toString();
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Column(
                children: [
                  BaseContainerForDriverInfo(
                    title: "Nereden Gideceksiniz?",
                    hintText: "Ankara",
                    controller: viewModel.forDriverFromWhere,
                  ),
                  const SizedBox(height: 26),
                  BaseContainerForDriverInfo(
                    title: "Nereye Gideceksiniz?",
                    hintText: "İstanbul",
                    controller: viewModel.forDriverToWhere,
                  ),
                  const SizedBox(height: 26),
                  BaseContainerForDriverInfo(
                    title: "İstediğiniz Fiyat Nedir?",
                    hintText: "22",
                    suffixIcon: const Text('TL'),
                    controller: viewModel.forDriverPrice,
                  ),
                  const SizedBox(height: 26),
                  BaseSelectTimeOrCalender(
                    icon: Icons.calendar_month,
                    title: "Gideceğiniz Tarih?",
                    selectTime: formattedDate.toString(),
                    onTap: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2000),
                        lastDate: DateTime(2100),
                      ).then(
                        (selecetdDate) {
                          if (selecetdDate != null) {
                            viewModel.driverSelectedCalender(selecetdDate);
                          }
                        },
                      );
                    },
                  ),
                  const SizedBox(height: 26),
                  BaseSelectTimeOrCalender(
                    icon: Icons.alarm,
                    title: "Gideceğiniz Tarih?",
                    selectTime:
                        TimeOfDay.fromDateTime(viewModel.driverSelectedTime)
                            .format(context),
                    onTap: () {
                      showTimePicker(
                              context: context, initialTime: TimeOfDay.now())
                          .then(
                        (selectedTime) {
                          if (selectedTime != null) {
                            final selectedDateTime = DateTime(
                              viewModel.driverSelectedTime.year,
                              viewModel.driverSelectedTime.month,
                              viewModel.driverSelectedTime.day,
                              selectedTime.hour,
                              selectedTime.minute,
                            );
                            viewModel
                                .driverSelectedChooseTime(selectedDateTime);
                          }
                        },
                      );
                    },
                  ),
                  SizedBox(height: context.getDynmaicHeight(.3)),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(
                        context.getDynmaicWidth(.6),
                        context.getDynmaicHeight(.05),
                      ),
                    ),
                    onPressed: () {
                      viewModel.saveDriverInfo();
                      Navigator.pop(context);
                      viewModel.forDriverFromWhere.clear();
                      viewModel.forDriverToWhere.clear();
                      viewModel.forDriverPrice.clear();
                    },
                    child: Text("Yolculuğu Oluştur"),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
