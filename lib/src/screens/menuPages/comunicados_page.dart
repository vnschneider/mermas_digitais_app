import 'package:flutter/material.dart';
import 'package:mermas_digitais_app/src/models/post_model.dart';

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
        elevation: 3,
        toolbarHeight: 70,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15))),
        title: const Text(
          'Comunicados',
          style: TextStyle(
              color: Color.fromARGB(255, 221, 199, 248),
              fontFamily: 'PaytoneOne',
              //fontWeight: FontWeight.bold,
              fontSize: 28),
        ),
        backgroundColor: const Color.fromARGB(255, 51, 0, 67),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 40),
          child: ListView.builder(
              itemCount: posts.length,
              itemBuilder: (context, index) {
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    Card(
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
                                  posts[index].postTitle,
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
                                Expanded(
                                  child: Text(
                                    maxLines: 3,
                                    textAlign: TextAlign.start,
                                    overflow: TextOverflow.ellipsis,
                                    posts[index].postConteudo,
                                    style: const TextStyle(
                                      color: Color.fromARGB(255, 51, 0, 67),
                                      fontFamily: "Poppins",
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
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
