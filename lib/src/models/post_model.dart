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
    postTitle: 'postTitle',
    postConteudo: 'postConteudo',
  ),
  PostModel(
    postTitle: 'postTitle1',
    postConteudo: 'postConteudo1',
  ),
  PostModel(
    postTitle: 'postTitle2',
    postConteudo: 'postConteudo2',
  ),
  PostModel(
    postTitle: 'postTitle3',
    postConteudo: 'postConteudo3',
  ),
  PostModel(
    postTitle: 'postTitle4',
    postConteudo: 'postConteudo4',
  ),
  PostModel(
    postTitle: 'postTitle5',
    postConteudo: 'postConteudo5',
  ),
  PostModel(
    postTitle: 'postTitle6',
    postConteudo: 'postConteudo6',
  ),
  PostModel(
    postTitle: 'postTitle7',
    postConteudo: 'postConteudo7',
  ),
];
