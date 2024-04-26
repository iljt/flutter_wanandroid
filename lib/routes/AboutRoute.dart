import 'package:flutter/material.dart';

class AboutRoute extends StatelessWidget{
  const AboutRoute({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("关于我们"),
      ),
      body:
      const Center(
          child: Column(
             mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "WanAndroid V1.0",
              )
            ],
          )
      )


    );
  }
}