class Yaku {

  final String name;
  final int hanClosed; // 面前時の翻数.
  final int? hanOpen; // 鳴き時の翻数.
  bool selected;


  Yaku({
    required this.name,
    required this.hanClosed,
    this.hanOpen,
    this.selected = false,
  });


  int han({required bool isMenzen}) {
    if (isMenzen) return hanClosed;
    return hanOpen ?? 0;
  }


  bool canOpen() => hanOpen != null;
  
}
