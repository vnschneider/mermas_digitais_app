// ignore_for_file: file_names, non_constant_identifier_names

class PostModel {
  String PostTitle;
  String PostConteudo;

  PostModel({
    required this.PostTitle,
    required this.PostConteudo,
  });
}

List<PostModel> posts = [
  PostModel(
    PostTitle: 'Evento dia 08/03',
    PostConteudo:
        'Neste dia 8 teremos diversas atividades no campus para comemorar o dia das mulheres. Esperamos você!',
  ),
];
