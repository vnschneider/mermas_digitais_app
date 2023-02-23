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
    PostTitle: 'PostTitle',
    PostConteudo: 'PostConteudo',
  ),
  PostModel(
    PostTitle: 'PostTitle1',
    PostConteudo: 'PostConteudo1',
  ),
  PostModel(
    PostTitle: 'PostTitle2',
    PostConteudo: 'PostConteudo2',
  ),
  PostModel(
    PostTitle: 'PostTitle3',
    PostConteudo: 'PostConteudo3',
  ),
  PostModel(
    PostTitle: 'PostTitle4',
    PostConteudo: 'PostConteudo4',
  ),
  PostModel(
    PostTitle: 'PostTitle5',
    PostConteudo: 'PostConteudo5',
  ),
  PostModel(
    PostTitle: 'PostTitle6',
    PostConteudo: 'PostConteudo6',
  ),
  PostModel(
    PostTitle: 'PostTitle7',
    PostConteudo: 'PostConteudo7',
  ),
];
