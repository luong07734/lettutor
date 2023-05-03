import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class BookingModal extends StatefulWidget {
  final String bookingTime;
  final Function(String) onBook;

  BookingModal({required this.bookingTime, required this.onBook});

  @override
  _BookingModalState createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  final _notesController = TextEditingController();

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.bookingTime,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              widget.bookingTime,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.notes,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Container(
              padding: EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.grey,
                  width: 1.0,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: TextFormField(
                controller: _notesController,
                decoration: InputDecoration.collapsed(
                  hintText: AppLocalizations.of(context)!.enterNotes,
                ),
                maxLines: null,
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.cancel),
                ),
                ElevatedButton(
                  onPressed: () {
                    widget.onBook(_notesController.text);
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.book),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
