import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:some_developed/image_filter.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImageFilter(),
    );
  }
}

class AgeCalculator extends StatefulWidget {
  @override
  _AgeCalculatorState createState() => _AgeCalculatorState();
}

class _AgeCalculatorState extends State<AgeCalculator> {
  DateTime? _selectedDate;
  int? _age;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _calculateAge();
      });
    }
  }

  void _calculateAge() {
    if (_selectedDate != null) {
      final now = DateTime.now();
      print("This is Now Year: ${now.year}");
      print("This is SelectDate Year: ${_selectedDate!.year}");
      print("This is SelectDate After Date: ${_selectedDate!.isAfter(DateTime(now.year, now.month, now.day))}");
      final age = now.year - _selectedDate!.year - (_selectedDate!.isAfter(DateTime(now.year, now.month, now.day)) ? 1 : 0);
      setState(() {
        _age = age;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => _selectDate(context),
              child: Text(_selectedDate == null ? 'Select Birthdate' : 'Change Birthdate'),
            ),
            SizedBox(height: 16.0),
            Text(
              _selectedDate == null ? 'Please select a birthdate' : 'Selected Birthdate: ${DateFormat('dd-MM-yyyy').format(_selectedDate!)}',
            ),
            SizedBox(height: 16.0),
            Text(
              _age == null ? '' : 'Age: $_age years',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
