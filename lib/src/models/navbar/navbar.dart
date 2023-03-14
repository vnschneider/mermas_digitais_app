import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/utils/screens.dart';
import 'package:mermas_digitais_app/src/utils/icon_data.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int indexOf = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[indexOf],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black38,
              spreadRadius: 0,
              blurRadius: 10,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 38,
            selectedFontSize: 15,
            unselectedFontSize: 14,
            showSelectedLabels: false,
            showUnselectedLabels: true,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            backgroundColor: const Color.fromARGB(255, 51, 0, 67),
            unselectedItemColor: const Color.fromARGB(150, 221, 199, 248),
            selectedItemColor: const Color.fromARGB(255, 221, 199, 248),
            currentIndex: indexOf,
            onTap: (index) => setState(() => indexOf = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(widgetIcons[0]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(widgetIcons[1]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(widgetIcons[2]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(widgetIcons[3]),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
