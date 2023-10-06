import 'package:flutter/material.dart';

class TopBar extends StatelessWidget {
  const TopBar({super.key});

  @override
  Widget build(BuildContext context) {
    return //top bar
          Container(
            decoration: BoxDecoration(
                border: Border.all(
                    color: Colors.black,
                    width: 0.5,
                    style: BorderStyle.solid,
                    strokeAlign: BorderSide.strokeAlignOutside)),
            padding: EdgeInsets.fromLTRB(10, 10, 10, 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Icon(
                    Icons.image,
                    color: Colors.black,
                  ),
                  Icon(
                    Icons.person_2_rounded,
                    color: Colors.black,
                  )
                ]),
          );
  }
}