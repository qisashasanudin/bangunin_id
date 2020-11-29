import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key key,
    void onPressed,
    String prompt,
  })  : this.onPressed = onPressed,
        this.prompt = prompt,
        super(key: key);

  final Function onPressed;
  final String prompt;

  @override
  Widget build(BuildContext context) {
    return RaisedButton(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
      color: AppColors().primary,
      child: Text(prompt, style: TextStyle(color: AppColors().accent1)),
      onPressed: onPressed,
    );
  }
}
