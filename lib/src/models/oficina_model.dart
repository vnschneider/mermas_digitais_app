class OficinaModel {
  String oficinaTitle;
  String oficinaDescri;
  String oficinaLink;

  OficinaModel({
    required this.oficinaTitle,
    required this.oficinaDescri,
    required this.oficinaLink,
  });
}

List<OficinaModel> oficinas = [
  OficinaModel(
    oficinaTitle: 'Ferramentas Tecnológicas',
    oficinaDescri: 'Aqui você irá aprender noções básicas de informática.',
    oficinaLink: 'OficinaLink',
  ),
  OficinaModel(
    oficinaTitle: 'Mão no Hardware',
    oficinaDescri:
        'Noções básicas de software e hardware incluindo instalação de SOs e montangem e manutenção de microcomputadores.',
    oficinaLink: 'OficinaLink1',
  ),
  OficinaModel(
    oficinaTitle: 'Aprendendo a Programar',
    oficinaDescri:
        'O conteúdo da oficina inclui: Algorítimos e introdução à lógica de programação.',
    oficinaLink: 'OficinaLink2',
  ),
];
