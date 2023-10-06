import 'package:expenses/model/Expenses.dart';
import 'package:expenses/screens/add_expenses.dart';
import 'package:expenses/widgets/bottom_bar.dart';
import 'package:expenses/widgets/list_item.dart';
import 'package:expenses/widgets/top_bar.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  ExpensesList({required this.expenses_list});
  final List<Expenses> expenses_list;

  @override
  State<ExpensesList> createState() => _ExpensesListState();
}

class _ExpensesListState extends State<ExpensesList> {
  List<Expenses> result_list = [];

//this method to set the filtered_list when the user enter a character in the search 
  void filterList(String query) {
    setState(() {
      result_list.clear();
    
      for (final expense in widget.expenses_list) {
        print(expense.title.toString() +
            " " +
            (expense.title.toLowerCase().contains(query.toLowerCase()))
                .toString());
        if (expense.title.toLowerCase().contains(query.toLowerCase())) {
          result_list.add(expense);
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    //can replace it with retrive code from firebase 
    result_list.addAll(widget.expenses_list);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //bottom bar
      bottomNavigationBar: BottomBar(
        expenses_list: widget.expenses_list,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //top bar
          TopBar(),

          Padding(
            padding: EdgeInsets.all(20),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Expenses List',
                    style: TextStyle(fontSize: 25, color: Colors.black),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    width: 250,
                    height: 30,
                    decoration:
                        BoxDecoration(border: Border.all(color: Colors.grey)),
                    child: Row(
                      children: [
                        Padding(
                          padding: EdgeInsets.fromLTRB(5, 0, 0, 0),
                          child: Icon(Icons.search),
                        ),
                        SizedBox(
                          width: 30,
                        ),
                        Expanded(
                            child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search here ...', // Optional hint text
                            border:
                                InputBorder.none, // Remove the default border
                          ),
                          onChanged: (value) {
                            filterList(value);
                          },
                        ))
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 25,
                  ),
                  //listview Scrollable with fixed height
                  Container(
                    height: 300,
                    child: ListView.builder(
                      itemCount: result_list.length,
                      itemBuilder: (context, index) {
                        //there is a small issue here the result data in the console not as in the screen 
                        print(
                            'result_list at index $index: ${result_list[index].title}');
                        return ListItem(
                          title: result_list[index].title,
                          total: result_list[index].amount * 10,
                          index: index,
                          expenses_list: result_list,
                        );
                      },
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  //used this line to check the updates of result_list
                  // Text(result_list.isNotEmpty ? result_list[0].title.toString() : 'No results'),

                  
                  //add button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          print(widget.expenses_list.length);
                          // navigate to the other screen
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => AddExpenses(
                                        expenses_list: widget.expenses_list,
                                      )));
                        },
                        style: ElevatedButton.styleFrom(
                          shape: CircleBorder(),
                          padding: EdgeInsets.all(16.0),
                        ),
                        child: Icon(
                          Icons.add,
                          size: 32.0,
                        ),
                      ),
                    ],
                  ),
                ]),
          ),
        ],
      ),
    );
  }
}
