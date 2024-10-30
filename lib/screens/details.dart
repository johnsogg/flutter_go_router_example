import 'package:flutter/material.dart';
import 'package:navigate/controllers/thing_controller.dart';
import 'package:provider/provider.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThingController thingController = Provider.of<ThingController>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
            "${thingController.list[thingController.thingIdx].name} Details"),
      ),
      body: Center(
          child:
              Text(thingController.list[thingController.thingIdx].description)),
    );
  }
}
