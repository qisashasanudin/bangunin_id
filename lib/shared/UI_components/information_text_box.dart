import 'package:flutter/material.dart';

class InformationTextBox extends StatelessWidget {
  const InformationTextBox({
    Key key,
    this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: Text(
          text,
          textAlign: TextAlign.center,
        ),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.grey[300],
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25.0),
            bottomRight: Radius.circular(25.0),
          ),
        ),
      ),
    );
  }
}
