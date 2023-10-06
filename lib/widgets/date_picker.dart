import 'package:flutter/material.dart';

class DatePicker extends StatelessWidget {
  const DatePicker(this.date, this.newDate, this.changeDate);

  final DateTime? newDate;
  final String date;
  final Function() changeDate;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: double.infinity,
      decoration: BoxDecoration(border: Border.all(color: Colors.black)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('$date'),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 50,
                width: 1,
                color: Colors.black,
              ),
              ElevatedButton(
                onPressed: changeDate,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: EdgeInsets.all(18.0), // Adjust the padding as needed
                ),
                child: Icon(
                  Icons.calendar_month,
                  color: Colors.black, // Adjust the icon size as needed
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
