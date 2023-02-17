import 'package:custom_line_indicator_bottom_navbar/custom_line_indicator_bottom_navbar.dart';
import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/menuPages/comunicadosPage.dart';
import 'package:mermas_digitais_app/menuPages/frequenciaPage.dart';
import 'package:mermas_digitais_app/menuPages/oficinasPage.dart';
import 'package:mermas_digitais_app/menuPages/perfilPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0; //default index

  final List<Widget> _widgetOptions = [
    ComunicadosPage(),
    OficinasPage(),
    FrequenciaPage(),
    PerfilPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: CustomLineIndicatorBottomNavbar(
        selectedColor: const Color.fromARGB(255, 221, 199, 248),
        unSelectedColor: const Color.fromARGB(255, 221, 199, 248),
        backgroundColor: const Color.fromARGB(255, 51, 0, 67),
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        enableLineIndicator: true,
        lineIndicatorWidth: 3,
        indicatorType: IndicatorType.Bottom,
        // gradient: LinearGradient(
        //   colors: kGradients,
        // ),

        customBottomBarItems: [
          CustomBottomBarItems(
            label: 'Comunicados',
            icon: Icons.home,
          ),
          CustomBottomBarItems(
            label: 'Oficinas',
            icon: Icons.account_box_outlined,
          ),
          CustomBottomBarItems(
              label: 'Frequência', icon: Icons.calendar_today_outlined),
          CustomBottomBarItems(
            label: 'Perfil',
            icon: Icons.person,
          ),
        ],
      ),
    );
  }
}
