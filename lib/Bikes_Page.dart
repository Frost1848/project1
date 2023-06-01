import 'package:akary/Buy_Page.dart';
import 'package:akary/Sell_Page.dart';
import 'package:flutter/material.dart';

class BikesPage extends StatelessWidget {
  final List<String> bikes = [
    'Ducati',
    'Harley Davidson',
    'Yamaha',
    'Kawasaki',
    'Honda',
    'Suzuki',
    'BMW',
    'KTM',
    'Triumph',
    'Royal Enfield',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bikes Page'),
        foregroundColor: Color.fromARGB(255, 240, 234, 234),
        backgroundColor: Color.fromARGB(255, 10, 2, 2),
      ),
      body: ListView.builder(
        itemCount: bikes.length,
        itemBuilder: (context, index) {
          final bike = bikes[index];
          return Card(
            child: ListTile(
              title: Text(bike),
              leading: Icon(Icons.motorcycle),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      // Handle sell button tap event
                      // Add your logic here
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 216, 2, 2), // Background color
                    ),
                    child: Text('BUY'),
                  ),
                  SizedBox(width: 8),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => SellPage()),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      primary:
                          Color.fromARGB(255, 11, 11, 11), // Background color
                    ),
                    child: Text('SELL'),
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BuyPage()),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
