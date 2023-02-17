import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class ComunicadosPage extends StatefulWidget {
  const ComunicadosPage({super.key});

  @override
  State<ComunicadosPage> createState() => _ComunicadosPageState();
}

class _ComunicadosPageState extends State<ComunicadosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          elevation: 4,
          toolbarHeight: 60,
          title: Text('Comunicados'),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                margin:
                    EdgeInsets.only(left: 16, right: 16, bottom: 10, top: 20),
                padding: EdgeInsets.all(16.0),
                decoration: BoxDecoration(
                    color: Colors.deepPurple,
                    borderRadius: BorderRadius.all(
                      Radius.circular(15),
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 10,
                        spreadRadius: 1,
                      )
                    ]),
                child: Text("Card 1"),
              ),
            ],
          ),
        ));
  }
}
