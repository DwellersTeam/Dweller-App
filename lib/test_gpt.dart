import 'package:flutter/material.dart';




class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<List<String>> propertyImages = [
    ['assets/property1_1.jpg', 'assets/property1_2.jpg', 'assets/property1_3.jpg'],
    ['assets/property2_1.jpg', 'assets/property2_2.jpg', 'assets/property2_3.jpg'],
    ['assets/property3_1.jpg', 'assets/property3_2.jpg', 'assets/property3_3.jpg'],
  ];

  // To track which image is being displayed for each property
  List<int> imageIndex = [];

  @override
  void initState() {
    super.initState();
    imageIndex = List.generate(propertyImages.length, (index) => 0);
  }

  void onImageTap(int index) {
    setState(() {
      imageIndex[index] = (imageIndex[index] + 1) % propertyImages[index].length;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: ListView.builder(
        itemCount: propertyImages.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () => onImageTap(index),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(propertyImages[index][imageIndex[index]]),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
