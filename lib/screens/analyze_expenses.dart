import 'dart:math';

import 'package:expenses/model/Expenses.dart';
import 'package:expenses/model/barChart.dart';
import 'package:expenses/widgets/bottom_bar.dart';
import 'package:expenses/widgets/top_bar.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class AnalyzeExpenses extends StatelessWidget {
  AnalyzeExpenses({required this.expenses_list});

  List<BarChartModel> data = [];
  List<charts.Series<BarChartModel, String>> series = [];
  final List<Expenses> expenses_list;
  int total = 0, min = 0, max = 0;
  List<int> totals = [];
  double avg = 0;
  String average = '';
  // using a hashMap to map a data between 12 months and thier total values 
  Map<int, int> month_map = {};

  void compute() {
    total = 0;
    totals = [];
    avg = 0;
    average = '';
    if (expenses_list.length.toDouble() == 0) {
      avg = 0.0;
      min = 0;
      max = 0;
      total = 0;
    } else {
      for (final expense in expenses_list) {
        //print(expense.title);
        total += (expense.amount * 10);
        totals.add(expense.amount);
      }
      avg = total / totals.length.toDouble();
      average = avg.toStringAsFixed(1);
      totals.sort();
      min = totals[0] * 10;
      max = totals[totals.length - 1] * 10;
    }
  }

//used this function to map each month 
  void mapping() {
    String month = '', full_date = '';

    for (final expense in expenses_list) {
      full_date = expense.date.replaceAll(' ', '');
      if (full_date[6] != '-') {
        month = full_date.substring(5, 7);
      } else {
        month = full_date.substring(5, 6);
      }

      if (month_map.containsKey(int.parse(month))) {
        month_map.update(
            int.parse(month), (value) => value + expense.amount * 10);
      } else {
        month_map[int.parse(month)] = expense.amount * 10;
      }
    }
    print(month_map.toString());
  }

// this is method if we want to add a random color for each col in the charts
  Color randomColor() {
    Random random = new Random();
    int red = random.nextInt(256);
    int green = random.nextInt(256);
    int blue = random.nextInt(256);
    return Color.fromRGBO(red, green, blue, 1.0);
  }

  void barChartData() {
   
    month_map.forEach((key, value) {
      data.add(BarChartModel(month: key.toString(), total: value));
    });
    print(data.length);
  }

 //declare series barcharts with its configuration 
  void configureListChart() {
    series = [
      charts.Series(
        id: "statistics",
        data: data,
        domainFn: (BarChartModel series, _) => series.month,
        measureFn: (BarChartModel series, _) => series.total,
      )
    ];
  }

  @override
  Widget build(BuildContext context) {
    //invoke all methods to set up the enviroment 
    compute();
    mapping();
    barChartData();
    configureListChart();
    //used a mediaquery for height property in the container 
    double screenHeight = MediaQuery.of(context).size.height;
    double containerHeight = screenHeight * 0.15;

    return Scaffold(
      bottomNavigationBar: BottomBar(
        expenses_list: expenses_list,
      ),
      body: Column(
        children: [
          //topbar
          TopBar(),
          Padding(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monthly Expenses',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                //barchart
                Container(
                  height: containerHeight * 2,
                  child: charts.BarChart(
                    series,
                    animate: true, // Enable animation for the chart
                  ),
                ),

                
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Summary Statistics',
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: containerHeight,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('$total\$'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Total')
                        ],
                      ),
                      Container(
                        height: containerHeight,
                        width: 1,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('$average\$'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Average')
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: containerHeight,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('$min\$'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Min')
                        ],
                      ),
                      Container(
                        height: containerHeight,
                        width: 1,
                        color: Colors.black,
                      ),
                      Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.symmetric(vertical: 15),
                            child: Text('$max.0\$'),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Text('Max')
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
