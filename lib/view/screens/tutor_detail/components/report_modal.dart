import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';

class ReportModal extends StatefulWidget {
  final String tutorName;
  final Function(String) onReport;

  ReportModal({required this.tutorName, required this.onReport});

  @override
  _ReportModalState createState() => _ReportModalState();
}

class _ReportModalState extends State<ReportModal> {
  final _reportController = TextEditingController();

  @override
  void dispose() {
    _reportController.dispose();
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
              AppLocalizations.of(context)!.reportTutor(widget.tutorName),
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              AppLocalizations.of(context)!.pleaseHelpUsUnderstand,
              style: TextStyle(
                fontSize: 16,
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
                controller: _reportController,
                decoration: InputDecoration.collapsed(
                  hintText: AppLocalizations.of(context)!.reportDetails,
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
                    widget.onReport(_reportController.text);
                    Navigator.pop(context);
                  },
                  child: Text(AppLocalizations.of(context)!.report),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
