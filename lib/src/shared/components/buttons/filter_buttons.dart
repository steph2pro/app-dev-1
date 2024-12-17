import 'package:flutter/material.dart';

class FilterButtons extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Filtrez les personnes que vous voulez rencontrer',
            style: TextStyle(fontSize: size.width / 42, color: Colors.white),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('18 - 28 ans', Icons.star, Colors.green, size),
              SizedBox(width: 10),
              _buildButton('Douala', Icons.location_on, Colors.orange, size),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton('Français', Icons.language, Colors.purple, size),
              SizedBox(width: 10),
              _buildButton('Célibataires', Icons.person, Colors.red, size),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text, IconData icon, Color color, Size size) {
    return Container(
      width: size.width / 3,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.white),
          SizedBox(width: 5),
          Text(
            text,
            style: TextStyle(
                color: Colors.white,
                fontSize: size.width / 50,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
