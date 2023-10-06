import 'package:expenses/screens/add_expenses.dart';
import 'package:expenses/screens/analyze_expenses.dart';
import 'package:expenses/screens/expenses_list.dart';
import 'package:expenses/widgets/date_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ExpensesList(expenses_list: []),
    );
  }
}
