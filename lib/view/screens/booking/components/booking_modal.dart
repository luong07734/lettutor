import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localization.dart';
import 'package:lettutor/data/provider/authentication_provider.dart';
import 'package:provider/provider.dart';

class BookingModal extends StatefulWidget {
  final String bookingTime;
  final Function(String) onBook;

  BookingModal({required this.bookingTime, required this.onBook});

  @override
  _BookingModalState createState() => _BookingModalState();
}

class _BookingModalState extends State<BookingModal> {
  final _notesController = TextEditingController();
  String balance = "";
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    context.read<AuthenticationProvider>().loadUser1().then((value) {
      setState(() {
        print("balance load");
        print(
            "balance ${context.read<AuthenticationProvider>().currentLoggedUser!.walletInfo!.amount!}");
        balance = context
            .read<AuthenticationProvider>()
            .currentLoggedUser!
            .walletInfo!
            .amount!;
        isLoading = false;
      });
    });
  }

  @override
  void dispose() {
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('BookingModal balance: balance');
    return isLoading
        ? Center(
            child: CircularProgressIndicator(
              valueColor: const AlwaysStoppedAnimation(Colors.blue),
              backgroundColor: Colors.grey[200],
            ),
          )
        : Dialog(
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
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(AppLocalizations.of(context)!.balance),
                          ),
                          Expanded(
                            child: Text(AppLocalizations.of(context)!
                                .youHaveLesson(int.parse(balance) ~/ 100000)),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: Text(AppLocalizations.of(context)!.price),
                          ),
                          Expanded(
                            child:
                                Text(AppLocalizations.of(context)!.oneLesson),
                          ),
                        ],
                      ),
                    ],
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
                        style: int.parse(balance) ~/ 100000 < 1
                            ? ElevatedButton.styleFrom(
                                foregroundColor: Colors.grey,
                                backgroundColor: Colors
                                    .grey[300], // Button color when disabled
                                elevation: 0, // No shadow when disabled
                              )
                            : null,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
  }
}
