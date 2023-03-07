import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:mermas_digitais_app/src/menuPages/comunicados_page.dart';
import 'package:mermas_digitais_app/src/menuPages/frequencia_page.dart';
import 'package:mermas_digitais_app/src/menuPages/oficinas_page.dart';
import 'package:mermas_digitais_app/src/menuPages/perfil_page.dart';

class Navbar extends StatefulWidget {
  const Navbar({super.key});

  @override
  State<Navbar> createState() => _NavbarState();
}

class _NavbarState extends State<Navbar> {
  int indexOf = 0;
  final telas = const [
    ComunicadosPage(),
    OficinasPage(),
    FrequenciaPage(),
    PerfilPage(),
  ];

  final List<IconData> _widgetIcons = [
    Iconsax.home,
    Iconsax.book,
    Iconsax.chart,
    Iconsax.profile_2user,
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: telas[indexOf],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.only(
              topRight: Radius.circular(15), topLeft: Radius.circular(15)),
          boxShadow: [
            BoxShadow(color: Colors.black38, spreadRadius: 0, blurRadius: 10),
          ],
        ),
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(30.0),
            topRight: Radius.circular(30.0),
          ),
          child: BottomNavigationBar(
            iconSize: 32,
            selectedFontSize: 15,
            unselectedFontSize: 14,
            showSelectedLabels: false,
            showUnselectedLabels: false,
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 51, 0, 67),
            unselectedItemColor: const Color.fromARGB(150, 221, 199, 248),
            selectedItemColor: const Color.fromARGB(255, 221, 199, 248),
            currentIndex: indexOf,
            onTap: (index) => setState(() => indexOf = index),
            items: [
              BottomNavigationBarItem(
                icon: Icon(_widgetIcons[0]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(_widgetIcons[1]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(_widgetIcons[2]),
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(_widgetIcons[3]),
                label: '',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
