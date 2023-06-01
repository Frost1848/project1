import 'package:flutter/material.dart';

class BuyPage extends StatefulWidget {
  @override
  _BuyPageState createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
  String? selectedItem;

  List<String> buyOptions = [
    'Cars',
    'Bikes',
    'Accessories',
    'Spare Parts',
    'Other',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Buy Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'What would you like to buy?',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            DropdownButtonFormField<String>(
              value: selectedItem,
              onChanged: (value) {
                setState(() {
                  selectedItem = value;
                });
              },
              items: buyOptions.map((option) {
                return DropdownMenuItem<String>(
                  value: option,
                  child: Text(option),
                );
              }).toList(),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Select an option',
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle buy button tap event
                if (selectedItem != null) {
                  // Perform action based on the selected item
                  print('User selected to buy: $selectedItem');
                } else {
                  // No option selected, display an error message or take appropriate action
                  print('Please select an option');
                }
              },
              child: Text('Buy'),
            ),
          ],
        ),
      ),
    );
  }
}
