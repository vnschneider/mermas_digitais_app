// ignore_for_file: file_names, non_constant_identifier_names

class OficinaModel {
  String OficinaTitle;
  String OficinaDescri;
  String Oficinalink;

  OficinaModel({
    required this.OficinaTitle,
    required this.OficinaDescri,
    required this.Oficinalink,
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
