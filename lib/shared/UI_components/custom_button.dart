import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String prompt;
  final Function() onPressed;

  const CustomButton({
    Key key,
    @required this.onPressed,
    @required this.prompt,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: AppColors().primary,
        child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
