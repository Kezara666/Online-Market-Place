import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';

class Timeslots extends StatefulWidget {
  const Timeslots({Key? key}) : super(key: key);

  @override
  State<Timeslots> createState() => _TimeslotsState();
}

class _TimeslotsState extends State<Timeslots> {
  @override
  Widget build(BuildContext context) {
    return GroupButton(
      buttons: const [
        "9am -10am",
        '10am-12pm',
        '12pm-2pm',
        '2pm-6pm',
        '6pm-9pm',
        '9pm-11pm'
      ],
      options: GroupButtonOptions(
        direction: Axis.vertical,
        spacing: 10,
        buttonHeight: 50,
        buttonWidth: 250,
        selectedColor: const Color.fromARGB(255, 119, 192, 79),
        borderRadius: BorderRadius.circular(10),
        selectedBorderColor: const Color.fromARGB(255, 255, 255, 255),
        unselectedBorderColor: const Color.fromARGB(255, 119, 192, 79),
      ),
      isRadio: false,
      maxSelected: 1,
    );
  }
}
