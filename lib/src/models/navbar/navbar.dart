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

  lineAnimation() {
    selected = !selected;
  }

  ativatedIcon(IconData icon) {
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
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(54, 0, 0, 0),
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
            enableFeedback: true,
            iconSize: 36,
            selectedFontSize: 15,
            unselectedFontSize: 14,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
            backgroundColor: const Color.fromARGB(255, 51, 0, 67),
            unselectedItemColor: const Color.fromARGB(150, 221, 199, 248),
            selectedItemColor: const Color.fromARGB(255, 221, 199, 248),
            currentIndex: indexOf,
            onTap: (index) => setState(() {
              indexOf = index;
              //selected = !selected;
              lineAnimation();
            }),
            items: [
              BottomNavigationBarItem(
                tooltip: 'Comunicados',
                icon: Icon(widgetIcons[0]),
                activeIcon: ativatedIcon(widgetIcons[0]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(widgetIcons[1]),
                label: '',
                tooltip: 'Oficinas',
                activeIcon: ativatedIcon(widgetIcons[1]),
              ),
              BottomNavigationBarItem(
                tooltip: 'Frequência',
                icon: Icon(widgetIcons[2]),
                activeIcon: ativatedIcon(widgetIcons[2]),
                label: '',
              ),
              BottomNavigationBarItem(
                tooltip: 'Perfil',
                icon: Icon(widgetIcons[3]),
                activeIcon: ativatedIcon(widgetIcons[3]),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
