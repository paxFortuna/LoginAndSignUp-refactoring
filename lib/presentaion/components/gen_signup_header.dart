import 'package:flutter/material.dart';

class GenLoginSignupHeader extends StatelessWidget {
  final String headerName;

  const GenLoginSignupHeader({super.key, required this.headerName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(height: 20.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/assets/images/tarotWheel.png",
                height: 50.0,
                width: 50.0,
              ),
              const SizedBox(width: 10.0),
              Text(
                headerName,
                style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                    fontSize: 30.0),
              ),
            ],
          ),          
          const SizedBox(height: 10.0),
        ],
      ),
    );
  }
}
