import 'package:expenses/model/Expenses.dart';
import 'package:expenses/screens/analyze_expenses.dart';
import 'package:expenses/screens/expenses_list.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  BottomBar({required this.expenses_list});
  final List<Expenses> expenses_list;

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  Color color1 = Colors.white, color2 = Colors.white;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
      decoration: BoxDecoration(
          border: Border.all(
              color: Colors.black,
              width: 0.5,
              strokeAlign: BorderSide.strokeAlignOutside,
              style: BorderStyle.solid)),
      height: 60,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    color1 = Colors.grey;
                    color2 = Colors.white;
                  });
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ExpensesList(
                                expenses_list: widget.expenses_list,
                              )));
                },
                child: Text(
                  'Manage Expenses',
                  style: TextStyle(color: Colors.black),
                ),
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.0),
                      side: BorderSide(
                        color: Colors.grey, // Set the border color you want
                      )),
                  backgroundColor: color1,
                )),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  color2 = Colors.grey;
                  color1 = Colors.white;
                });
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => AnalyzeExpenses(
                              expenses_list: widget.expenses_list,
                            )));
              },
              child: Text(
                'Analyze Expenses',
                style: TextStyle(color: Colors.black),
              ),
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5.0),
                    side: BorderSide(
                      color: Colors.grey, // Set the border color you want
                    )),
                backgroundColor: color2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
