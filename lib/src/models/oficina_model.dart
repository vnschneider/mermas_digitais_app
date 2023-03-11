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
    oficinaTitle: 'oficinaTitle',
    oficinaDescri: 'oficinaDescri',
    oficinaLink: 'oficinaLink',
  ),
  OficinaModel(
    oficinaTitle: 'oficinaTitle1',
    oficinaDescri: 'oficinaDescri1',
    oficinaLink: 'oficinaLink1',
  ),
  OficinaModel(
    oficinaTitle: 'oficinaTitle2',
    oficinaDescri: 'oficinaDescri2',
    oficinaLink: 'oficinaLink2',
  ),
];
