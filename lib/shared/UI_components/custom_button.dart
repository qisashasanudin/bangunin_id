import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String prompt;
  final Icon icon;
  final Function() onPressed;

  const CustomButton({
    Key key,
    this.icon,
    @required this.prompt,
    @required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton.icon(
        icon: icon ?? Icon(Icons.check, color: AppColors().accent1),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        color: AppColors().primary,
        label: Text(prompt, style: TextStyle(color: AppColors().accent1)),
        onPressed: () {
          onPressed();
        },
      ),
    );
  }
}
