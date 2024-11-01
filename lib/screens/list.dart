import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:navigate/components/bottom_nav.dart';
import 'package:navigate/controllers/thing_controller.dart';
import 'package:provider/provider.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    ThingController thingController = Provider.of<ThingController>(context);

    return Scaffold(
        appBar: AppBar(title: const Text("List Screen")),
        bottomNavigationBar: const BottomNav(
          activeButtonIndex: 0,
        ),
        body: ListView.builder(
          itemCount: thingController.list.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(thingController.list[index].name),
              onTap: () {
                Provider.of<ThingController>(context, listen: false)
                    .changeIndex(index);
                context.go('/details');
              },
            );
          },
        ));
  }
}
