import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerPage extends StatefulWidget {
  const DatePickerPage({super.key});

  @override
  State<DatePickerPage> createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  DateTime? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        title: const Text("Date Picker"),
      ),
      body: Container(
        alignment: Alignment.center,
        color: const Color(0xFF673AB7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              selectedDate == null
                  ? "Your selected date will appear here"
                  : DateFormat.yMMMMd('en_US').format(selectedDate!).toString(),
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
                onPressed: () => selectDate(context),
                child: const Text("Pick date"))
          ],
        ),
      ),
    );
  }

  Future selectDate(BuildContext context) async {
    DateTime initialDate = DateTime.now();
    DateTime firstDate = DateTime(DateTime.now().year - 10);
    DateTime lastDate = DateTime(DateTime.now().year + 10);

    final date = await showDatePicker(
        context: context,
        initialDate: initialDate,
        firstDate: firstDate,
        lastDate: lastDate);

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }
}
