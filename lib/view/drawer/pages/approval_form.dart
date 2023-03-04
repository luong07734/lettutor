import 'package:flutter/material.dart';

class ApprovalForm extends StatefulWidget {
  @override
  _ApprovalFormState createState() => _ApprovalFormState();
}

class _ApprovalFormState extends State<ApprovalForm> {
  // Define a list of items for the timeline
  List<String> _timelineItems = ['Step 1', 'Step 2', 'Step 3', 'Step 4'];

  // Define a map to store the user input for each step
  Map<String, String> _formData = {
    'Step 1': '',
    'Step 2': '',
    'Step 3': '',
    'Step 4': '',
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Process Approval Form'),
      ),
      body: ListView.builder(
        itemCount: _timelineItems.length,
        itemBuilder: (context, index) {
          return ExpansionTile(
            title: Text(
              _timelineItems[index],
              style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
            ),
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  children: <Widget>[
                    TextFormField(
                      decoration: InputDecoration(labelText: 'Input data'),
                      onChanged: (value) {
                        setState(() {
                          _formData[_timelineItems[index]] = value;
                        });
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      child: Text(
                        'Approve ${_timelineItems[index]}',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // TODO: Implement approval logic
                      },
                    ),
                    SizedBox(height: 16.0),
                    ElevatedButton(
                      child: Text(
                        'Reject ${_timelineItems[index]}',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        // TODO: Implement rejection logic
                      },
                    ),
                    SizedBox(height: 16.0),
                    Text(
                      'Data entered: ${_formData[_timelineItems[index]]}',
                      style: TextStyle(fontSize: 16.0),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        onPressed: () {
          // TODO: Implement form submission logic
        },
      ),
    );
  }
}
