class PostModel {
  String postTitle;
  String postContent;

  PostModel({
    required this.postTitle,
    required this.postContent,
  });
}

List<PostModel> posts = [
  PostModel(
    postTitle: 'Evento dia 08/03',
    postContent:
        'Neste dia 8 teremos diversas atividades no campus para comemorar o dia das mulheres. Esperamos você!',
  ),
];
