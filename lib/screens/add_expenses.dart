import 'dart:math';

import 'package:expenses/model/Expenses.dart';
import 'package:expenses/screens/expenses_list.dart';
import 'package:expenses/widgets/bottom_bar.dart';
import 'package:expenses/widgets/date_picker.dart';
import 'package:expenses/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class AddExpenses extends StatefulWidget {
  AddExpenses({required this.expenses_list});
  List<Expenses> expenses_list = [];
  @override
  State<AddExpenses> createState() =>
      _AddExpensesState(expenses_list: expenses_list);
}

class _AddExpensesState extends State<AddExpenses> {
  _AddExpensesState({required this.expenses_list});

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  //declare variables to save them into Expenses object
  int amount = 0;
  DateTime? newDate;
  String date = '';
  String title = '';

  List<Expenses> expenses_list = [];
  List<Expenses> items = [];
  @override
  void initState() {
    super.initState();
    // Initialize the items list with the expenses_list from the parent widget
    items = expenses_list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //bottom bar
      bottomNavigationBar: BottomBar(
        expenses_list: items,
      ),
      body: Column(
        children: [
          //topbar
          TopBar(),
          SizedBox(
            height: 10,
          ),
          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Add Expenses',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(
                  height: 10,
                ),
                Text('Title'),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: TextField(
                      controller: _textEditingController,
                      decoration: InputDecoration(border: InputBorder.none),
                      //save the value you typed it
                      onChanged: (value) {
                        title = value;
                      },
                    ),
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                Text('Amount'),
                //this is ready widget from github the library
                NumberInputWithIncrementDecrement(
                  controller: _amountController,
                  //save the last value of amount
                  onIncrement: (newValue) {
                    amount = newValue.toInt();
                  },
                  onDecrement: (newValue) {
                    amount = newValue.toInt();
                  },
                ),

                SizedBox(
                  height: 20,
                ),

                Text('Date'),
                //call date picker widget and use a global stateful to pass argument 
                DatePicker(date, newDate, () async {
                  //open show date picker
                  newDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2023),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100));

                    //save and update the value of date
                  setState(() {
                    date = '  ' +
                        newDate!.year.toString() +
                        "-" +
                        newDate!.month.toString() +
                        "-" +
                        newDate!.day.toString();
                    //print(date);
                  });
                }),

                SizedBox(
                  height: 40,
                ),

                //Add button
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      //check that all fileds have value before add them into the local list 

                      if (title.isNotEmpty && amount > 0 && date.isNotEmpty) {
                        Expenses e =
                            Expenses(title: title, amount: amount, date: date);
                            //can replace this line to add into firebase 
                        items.add(e);

                  
                  // remove fileds 
                        setState(() {
                          date = '';
                          amount = 0;
                        });

                        _textEditingController.clear();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: BorderSide(color: Colors.black),
                    ),
                    child: Container(
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Add',
                          style: TextStyle(color: Colors.black),
                        )),
                  ),
                ),
                // back button
                IconButton(
                    onPressed: () {
                      //passing data with navigator and move to the first screen again 
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ExpensesList(
                                    expenses_list: widget.expenses_list,
                                  )));
                    },
                    icon: Icon(Icons.arrow_back)),
              ],
            ),
          )
        ],
      ),
    );
  }
}
