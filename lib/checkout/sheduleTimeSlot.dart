import 'package:flutter/material.dart';
import 'package:group_button/group_button.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SheduleTimeSlot extends StatefulWidget {
  const SheduleTimeSlot({Key? key}) : super(key: key);

  @override
  State<SheduleTimeSlot> createState() => _SheduleTimeSlotState();
}

// DatePickerController _controller = DatePickerController();

String timeslot = '';

final controller = GroupButtonController();
final List<String> cityList = [
  '9am -10am',
  '10am-12pm',
  '12pm-2pm',
  '2pm-6pm',
  '6pm-9pm',
  '9pm-11pm'
];

class _SheduleTimeSlotState extends State<SheduleTimeSlot> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {}

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Select Time Slot'),
      content: SizedBox(
        child: Column(
          children: [
            GroupButton(
              controller: controller,
              buttons: [
                "9am -10am",
                '10am-12pm',
                '12pm-2pm',
                '2pm-6pm',
                '6pm-9pm',
                '9pm-11pm'
              ],
              onSelected: (value, index, isSelected) => {
                if (isSelected)
                  {
                    timeslot = value.toString(),
                    print(timeslot),
                  }
              },
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
            ),
          ],
        ),
      ),
      actions: <Widget>[
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            fixedSize: const Size(600, 40),
            primary: const Color.fromARGB(255, 119, 192, 79),
          ),
          onPressed: () => {
            if (timeslot == '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Select Date And Time Slot'),
                  ),
                ),
              }
            else
              {
                // print(sendValue),
                Navigator.pop(context, timeslot),
              }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
