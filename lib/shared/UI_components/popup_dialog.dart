import 'package:bangunin_id/shared/UI_components/app_colors.dart';
import 'package:flutter/material.dart';

enum DialogAction { yes, no }

class PopUpDialog {
  static Future<DialogAction> yesNoDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    final action = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(body),
          actions: <Widget>[
            FlatButton(
              onPressed: () => Navigator.of(context).pop(DialogAction.yes),
              child: Text('Ya'),
            ),
            RaisedButton(
              color: Theme.of(context).primaryColor,
              onPressed: () => Navigator.of(context).pop(DialogAction.no),
              child: Text(
                'Tidak',
                style: TextStyle(color: AppColors().accent1),
              ),
            ),
          ],
        );
      },
    );
    return (action != null) ? action : DialogAction.no;
  }
}
