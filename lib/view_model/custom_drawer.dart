import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:marvel_project/view/home.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.purple,
            ),
            child: Center(
              child: Text(
                'Marvel Drawer',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontStyle: FontStyle.italic),
              ),
            ),
          ),
          ListTile(
            title: const Row(
              children: [
                Icon(Icons.home),
                SizedBox(
                  width: 10,
                ),
                Text("Ana Sayfa")
              ],
            ),
            onTap: () {
              Get.to(Home());
            },
          ),
        ],
      ),
    );
  }
}
