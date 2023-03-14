class PostModel {
  String postTitle;
  String postConteudo;

  PostModel({
    required this.postTitle,
    required this.postConteudo,
  });
}

List<PostModel> posts = [
  PostModel(
    postTitle: 'Evento dia 08/03',
    postConteudo:
        'Neste dia 8 teremos diversas atividades no campus para comemorar o dia das mulheres. Esperamos você!',
  ),
];
