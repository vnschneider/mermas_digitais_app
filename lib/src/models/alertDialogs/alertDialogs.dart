// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../showToastMessage.dart';

class ErrorAlertDialog extends StatelessWidget {
  const ErrorAlertDialog(
      {super.key, required this.title, required this.content});

  final String title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AlertDialog(
        backgroundColor: const Color.fromARGB(255, 221, 199, 248),
        title: Text(
          title,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 51, 0, 67),
          ),
        ),
        content: Text(
          content,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontFamily: "Poppins",
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Color.fromARGB(255, 51, 0, 67),
          ),
        ),
      ),
    );
  }
}

class PostAlertDialog extends StatelessWidget {
  const PostAlertDialog(
      {super.key,
      required this.postTitle,
      required this.postContent,
      required this.postLink});

  final String postTitle;
  final String postContent;
  final String postLink;

  _launchUrl(Uri url) async {
    try {
      if (await launchUrl(url, mode: LaunchMode.externalApplication)) {
        await canLaunchUrl(url);
      }
    } catch (e) {
      showToastMessage(message: 'Não foi possível abrir o link. Erro: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: const Color.fromARGB(255, 221, 199, 248),
      title: Text(
        postTitle,
        textAlign: TextAlign.center,
        style: const TextStyle(
            color: Color.fromARGB(255, 51, 0, 67),
            fontFamily: "PaytoneOne",
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      content: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        scrollDirection: Axis.vertical,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              postContent,
              textAlign: TextAlign.start,
              style: const TextStyle(
                color: Color.fromARGB(255, 51, 0, 67),
                fontFamily: "Poppins",
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10),
            postLink.isNotEmpty
                ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          if (postLink.isNotEmpty) {
                            _launchUrl(Uri.parse(postLink.toString()));
                          }
                        },
                        child: const Text(
                          'Mais sobre',
                          maxLines: 1,
                          textAlign: TextAlign.start,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Color.fromARGB(255, 51, 0, 67),
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  )
                : const SizedBox()
          ],
        ),
      ),
    );
  }
}
