class Yaku {

  final String name;
  int hanClosed; // 面前時の翻数.
  int hanOpened; // 鳴き時の翻数.
  bool selected;


  Yaku({
    required this.name,
    required this.hanClosed,
    required this.hanOpened,
    this.selected = false,
  });
}
