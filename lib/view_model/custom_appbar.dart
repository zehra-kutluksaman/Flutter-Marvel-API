import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.purple,
      title: const Padding(
        padding: EdgeInsets.all(40.0),
        child: Text(
          'Characters',
          style: TextStyle(
            fontSize: 40,
            color: Colors.white,
            fontStyle: FontStyle.italic,
          ),
        ),
      ),
      iconTheme: const IconThemeData(color: Colors.white),
    );
  }
}
