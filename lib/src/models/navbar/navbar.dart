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
  bool selected = false;

  @override
  void initState() {
    super.initState();
    selected = !selected;
  }

  activeIcon(IconData icon) {
    return Column(
      children: [
        Icon(
          icon,
          size: 36,
          color: const Color.fromARGB(255, 221, 199, 248),
        ),
        const SizedBox(height: 6),
        AnimatedContainer(
          onEnd: () => setState(() {
            selected = true;
          }),
          curve: Curves.elasticOut,
          duration: const Duration(milliseconds: 300),
          width: selected ? 36 : 10,
          decoration: BoxDecoration(
              border: Border(
                  bottom: BorderSide(
            width: 1.0,
            color: selected
                ? const Color.fromARGB(255, 221, 199, 248)
                : Colors.transparent,
          ))),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[indexOf],
      bottomNavigationBar: ClipRRect(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(22.0),
          topRight: Radius.circular(22.0),
        ),
        child: BottomNavigationBar(
          enableFeedback: true,
          iconSize: 36,
          selectedFontSize: 15,
          unselectedFontSize: 14,
          showSelectedLabels: true,
          showUnselectedLabels: false,
          type: BottomNavigationBarType.fixed,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          backgroundColor: const Color.fromARGB(255, 51, 0, 67),
          unselectedItemColor: const Color.fromARGB(150, 221, 199, 248),
          selectedItemColor: const Color.fromARGB(255, 221, 199, 248),
          currentIndex: indexOf,
          onTap: (index) => setState(() {
            indexOf = index;
          }),
          items: [
            BottomNavigationBarItem(
              tooltip: 'Comunicados',
              icon: Icon(widgetIcons[0]),
              activeIcon: activeIcon(widgetIcons[0]),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: Icon(widgetIcons[1]),
              label: '',
              tooltip: 'Oficinas',
              activeIcon: activeIcon(widgetIcons[1]),
            ),
            BottomNavigationBarItem(
              tooltip: 'Frequência',
              icon: Icon(widgetIcons[2]),
              activeIcon: activeIcon(widgetIcons[2]),
              label: '',
            ),
            BottomNavigationBarItem(
              tooltip: 'Perfil',
              icon: Icon(widgetIcons[3]),
              activeIcon: activeIcon(widgetIcons[3]),
              label: '',
            ),
          ],
        ),
      ),
    );
  }
}
