import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';

class SheduleDate extends StatefulWidget {
  const SheduleDate({Key? key}) : super(key: key);

  @override
  State<SheduleDate> createState() => _SheduleDateState();
}

// DatePickerController _controller = DatePickerController();

String _selectedDate = '';

class _SheduleDateState extends State<SheduleDate> {
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    setState(() {
      if (args.value is DateTime) {
        _selectedDate = args.value.toString();
        print(_selectedDate);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      scrollable: true,
      title: const Text('Select  Delivery Date'),
      content: SizedBox(
        child: Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width,
              height: 300,
              child: SfDateRangePicker(
                selectionMode: DateRangePickerSelectionMode.single,
                onSelectionChanged: _onSelectionChanged,
              ),
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
            if (_selectedDate == '')
              {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please Select Date And Time Slot'),
                  ),
                ),
              }
            else
              {
                Navigator.pop(context, _selectedDate),
              }
          },
          child: const Text('OK'),
        ),
      ],
    );
  }
}
