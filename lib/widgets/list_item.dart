import 'package:expenses/model/Expenses.dart';
import 'package:expenses/screens/expenses_list.dart';
import 'package:flutter/material.dart';

class ListItem extends StatefulWidget {
  const ListItem(
      {required this.title,
      required this.total,
      required this.index,
      required this.expenses_list});
  final int total;
  final String title;
  final int index;
  final List<Expenses> expenses_list;
  @override
  State<ListItem> createState() => _ListItemState(
      title: title,
      total: total,
      index: this.index,
      expenses_list: this.expenses_list);
}

class _ListItemState extends State<ListItem> {
  _ListItemState(
      {required this.title,
      required this.total,
      required this.index,
      required this.expenses_list});
  final int total;
  final String title;
  final int index;
  final List<Expenses> expenses_list;
  @override
  Widget build(BuildContext context) {

    return //list item
        Container(
      padding: EdgeInsets.only(left: 5),
      height: 82,
      margin: EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 5,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                InkWell(
                  onTap: () {
                    setState(() {
                      expenses_list.removeAt(index);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  ExpensesList(expenses_list: expenses_list)));
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                          color: Colors.black, width: 0.5), // Black border
                    ),
                    padding: EdgeInsets.all(1), // Adjust padding as needed
                    child: Text(
                      'Delete',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                      border: Border.all(
                          color: Colors.black, width: 0.5), // Black border
                    ),
                    padding: EdgeInsets.all(1), // Adjust padding as needed
                    child: Text(
                      'Update',
                      style: TextStyle(color: Colors.black, fontSize: 10),
                    ),
                  ),
                ),
                SizedBox(
                  width: 2,
                ),
              ],
            ),
            Text(
              '$title',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Total:$total\$',
              style: TextStyle(fontSize: 12),
            ),
          ]),
    );
  }
}
