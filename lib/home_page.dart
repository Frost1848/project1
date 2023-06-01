import 'dart:io';
import 'package:akary/Bikes_Page.dart';
import 'package:akary/Cars_Page.dart';
import 'package:akary/auth_services.dart';
import 'package:akary/cars.dart';
import 'package:akary/customer_profile.dart';
import 'package:akary/signup_page.dart';
import 'package:akary/login_page.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Homepage extends StatefulWidget {
  Homepage({Key? key}) : super(key: key);

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<String> _dataList = [];
  List<String> _searchResult = [];
  String? name;
  String? email;
  bool _isLoading = true;

  TextEditingController _searchController = TextEditingController();

  File? _profileImage; // Variable to hold the uploaded image file

  getUserName() async {
    setState(() {
      _isLoading = true;
    });
    final getReturns = await AuthServices.getUser();
    if (getReturns[0] != "success") {
      return;
    }
    setState(() {
      _isLoading = false;
      name = getReturns[1];
      email = getReturns[2];
    });
  }

  @override
  void initState() {
    super.initState();
    getUserName();
  }

  // Method to open file picker and select an image file
  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 0, 0, 0),
      appBar: AppBar(
        shadowColor: Colors.black,
        foregroundColor: Color.fromARGB(255, 133, 15, 15),
        title: TextField(
          style: TextStyle(color: Colors.white),
          controller: _searchController,
          cursorColor: Colors.white,
          decoration: InputDecoration(
            hintText: '  Search cars',
            hintStyle: TextStyle(
              fontSize: 20.0,
              color: Color.fromARGB(255, 112, 110, 110),
            ),
          ),
          onChanged: onSearchTextChanged,
        ),
        backgroundColor: Color.fromARGB(255, 6, 3, 7),
      ),
      drawer: Drawer(
        backgroundColor: Color.fromARGB(255, 108, 23, 23),
        child: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ListView(
                padding: EdgeInsets.zero,
                children: <Widget>[
                  UserAccountsDrawerHeader(
                    decoration:
                        BoxDecoration(color: Color.fromARGB(255, 30, 2, 2)),
                    accountName: Text(name!),
                    accountEmail: Text(email!),
                    currentAccountPicture: GestureDetector(
                      onTap: _pickImage,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        backgroundImage: _profileImage != null
                            ? FileImage(_profileImage!)
                                as ImageProvider<Object>?
                            : AssetImage('assets/default_profile.jpg'),
                        child: _profileImage == null
                            ? Text(
                                name![0] + name![name!.indexOf(' ') + 1],
                                style: TextStyle(
                                  fontSize: 40.0,
                                  color: Colors.black,
                                ),
                              )
                            : null,
                      ),
                    ),
                  ),
                  ListTile(
                    leading: Icon(Icons.home),
                    title: Text('Home'),
                    onTap: () {
                      Navigator.pop(context); // close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Homepage()),
                      );
                    },
                  ),
                  const Divider(
                    color: Color.fromARGB(255, 27, 6, 79),
                  ),
                  ListTile(
                    leading: Icon(Icons.person),
                    title: Text('Profile'),
                    onTap: () {
                      Navigator.pop(context); // close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CustomerProfile()),
                      );
                    },
                  ),
                  Divider(
                    color: Color.fromARGB(255, 38, 13, 97),
                  ),
                  ListTile(
                    leading: Icon(Icons.exit_to_app),
                    title: Text('Logout'),
                    onTap: () {
                      Navigator.pop(context); // close the drawer
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => Loginpage()),
                      );
                    },
                  ),
                ],
              ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CarsPage()),
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Cars(),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => BikesPage()),
                );
              },
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.green,
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Bikes(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void onSearchTextChanged(String text) {
    _searchResult.clear();
    if (text.isEmpty) {
      setState(() {});
      return;
    }
    _dataList.forEach((item) {
      if (item.toLowerCase().contains(text.toLowerCase())) {
        _searchResult.add(item);
      }
    });
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Container Demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Container Demo'),
        ),
        body: Center(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              color: Colors.blue,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Cars(),
          ),
        ),
      ),
    );
  }
}

class Cars extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 400,
        backgroundImage: AssetImage(
            'assets/car.jpg'), // Replace with your car image asset path
        backgroundColor: Color.fromARGB(244, 245, 1, 1),
      ),
    );
  }
}

class Bikes extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      decoration: BoxDecoration(
        color: Colors.blue,
        shape: BoxShape.circle,
      ),
      child: CircleAvatar(
        radius: 400,
        backgroundImage: AssetImage(
            'assets/bike.jpg'), // Replace with your car image asset path
        backgroundColor: Color.fromARGB(244, 245, 1, 1),
      ),
    );
  }
}

class UserBox extends StatelessWidget {
  final String name;
  final String email;
  final String phone;

  UserBox({required this.name, required this.email, required this.phone});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            name,
            style: TextStyle(
              fontSize: 24.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            email,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            phone,
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
