import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class WatchPage extends StatefulWidget {
  const WatchPage({super.key});

  @override
  State<WatchPage> createState() => _WatchPageState();
}

class _WatchPageState extends State<WatchPage> {

  final List<String> imageUrls = [
    'Imagem 1',
    'Imagem 2',
    'Imagem 3',
  ];


  Widget buildCarouseltItem(String text) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Container(
        width: 500,
        height: 500,
        color: Colors.green,
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              fontSize: 25,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 10),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              height: 150,
              width: 150,
              color: Colors.blueAccent,
            ),
          ),
          const SizedBox(height: 20),
          CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              enlargeCenterPage: true,
              enableInfiniteScroll: true,
              viewportFraction: 0.8,
            ),
            items: imageUrls.map(buildCarouseltItem).toList(),
          ),
        ],
      ),
    );
  }
}
