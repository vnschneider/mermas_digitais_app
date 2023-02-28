// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/oficina_model.dart';

class OficinasPage extends StatefulWidget {
  const OficinasPage({super.key});

  @override
  State<OficinasPage> createState() => _OficinasPageState();
}

class _OficinasPageState extends State<OficinasPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          elevation: 3,
          toolbarHeight: 70,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15))),
          title: const Text(
            'Oficinas',
            style: TextStyle(
                color: Color.fromARGB(255, 221, 199, 248),
                fontFamily: 'PaytoneOne',
                //fontWeight: FontWeight.bold,
                fontSize: 28),
          ),
          backgroundColor: const Color.fromARGB(255, 51, 0, 67)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
          child: ListView.builder(
              itemCount: oficinas.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    SizedBox(
                      width: double.infinity,
                      //height: 130,
                      child: Card(
                        color: const Color.fromARGB(255, 221, 199, 248),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    oficinas[index].OficinaTitle,
                                    style: const TextStyle(
                                        color: Color.fromARGB(255, 51, 0, 67),
                                        fontFamily: "PaytoneOne",
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    oficinas[index].OficinaDescri,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 51, 0, 67),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 20),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 51, 0, 67))),
                                    onPressed: () {},
                                    child: const Text(
                                      'Material de apoio',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 221, 199, 248),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  TextButton(
                                    style: ButtonStyle(
                                        shape: MaterialStateProperty.all<
                                                RoundedRectangleBorder>(
                                            RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(5))),
                                        backgroundColor:
                                            MaterialStateProperty.all(
                                                const Color.fromARGB(
                                                    255, 51, 0, 67))),
                                    onPressed: () {},
                                    child: const Text(
                                      'Monitores',
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 221, 199, 248),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}
