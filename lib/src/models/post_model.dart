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
    PostTitle: 'Evento dia 08/03',
    PostConteudo:
        'Neste dia 8 teremos diversas atividades no campus para comemorar o dia das mulheres. Esperamos você!',
  ),
];
