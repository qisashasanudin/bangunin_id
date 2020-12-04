import 'package:bangunin_id/shared/UI_components/popup_dialog.dart';
import 'package:flutter/cupertino.dart';

Future<bool> onBackPressed(BuildContext context) async {
  bool tappedYes = false;
  final action = await PopUpDialog.yesNoDialog(context, 'Kembali?',
      'Apakah anda yakin ingin kembali? Semua pengaturan pada halaman ini tidak akan tersimpan.');
  if (action == DialogAction.yes) {
    tappedYes = true;
  }
  return tappedYes;
}
