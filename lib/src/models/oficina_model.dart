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
    OficinaTitle: 'Ferramentas Tecnológicas',
    OficinaDescri: 'Aqui você irá aprender noções básicas de informática.',
    Oficinalink: 'OficinaLink',
  ),
  OficinaModel(
    OficinaTitle: 'Mão no Hardware',
    OficinaDescri:
        'Noções básicas de software e hardware incluindo instalação de SOs e montangem e manutenção de microcomputadores.',
    Oficinalink: 'OficinaLink1',
  ),
  OficinaModel(
    OficinaTitle: 'Aprendendo a Programar',
    OficinaDescri:
        'O conteúdo da oficina inclui: Algorítimos e introdução à lógica de programação.',
    Oficinalink: 'OficinaLink2',
  ),
];
