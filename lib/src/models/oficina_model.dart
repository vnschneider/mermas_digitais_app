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
    OficinaTitle: 'OficinaTitle',
    OficinaDescri: 'OficinaDescri',
    Oficinalink: 'OficinaLink',
  ),
  OficinaModel(
    OficinaTitle: 'OficinaTitle1',
    OficinaDescri: 'OficinaDescri1',
    Oficinalink: 'OficinaLink1',
  ),
  OficinaModel(
    OficinaTitle: 'OficinaTitle2',
    OficinaDescri: 'OficinaDescri2',
    Oficinalink: 'OficinaLink2',
  ),
];
