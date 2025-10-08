enum Images {
  //マンズ
  manzu_1("assets/images/manzu_1.png"),
  manzu_2("assets/images/manzu_2.png"),
  manzu_3("assets/images/manzu_3.png"),
  manzu_4("assets/images/manzu_4.png"),
  manzu_5("assets/images/manzu_5.png"),
  // manzu_5r("assets/images/manzu_5r.png"),
  manzu_6("assets/images/manzu_6.png"),
  manzu_7("assets/images/manzu_7.png"),
  manzu_8("assets/images/manzu_8.png"),
  manzu_9("assets/images/manzu_9.png"),
  //ピンズ
  pinzu_1("assets/images/pinzu_1.png"),
  pinzu_2("assets/images/pinzu_2.png"),
  pinzu_3("assets/images/pinzu_3.png"),
  pinzu_4("assets/images/pinzu_4.png"),
  pinzu_5("assets/images/pinzu_5.png"),
  // pinzu_5r("assets/images/pinzu_5r.png"),
  pinzu_6("assets/images/pinzu_6.png"),
  pinzu_7("assets/images/pinzu_7.png"),
  pinzu_8("assets/images/pinzu_8.png"),
  pinzu_9("assets/images/pinzu_9.png"),
  //ソウズ
  souzu_1("assets/images/souzu_1.png"),
  souzu_2("assets/images/souzu_2.png"),
  souzu_3("assets/images/souzu_3.png"),
  souzu_4("assets/images/souzu_4.png"),
  souzu_5("assets/images/souzu_5.png"),
  // souzu_5r("assets/images/souzu_5r.png"),
  souzu_6("assets/images/souzu_6.png"),
  souzu_7("assets/images/souzu_7.png"),
  souzu_8("assets/images/souzu_8.png"),
  souzu_9("assets/images/souzu_9.png"),
  //ジハイ
  zihai_1("assets/images/zihai_1.png"),
  zihai_2("assets/images/zihai_2.png"),
  zihai_3("assets/images/zihai_3.png"),
  zihai_4("assets/images/zihai_4.png"),
  zihai_5("assets/images/zihai_5.png"),
  zihai_6("assets/images/zihai_6.png"),
  zihai_7("assets/images/zihai_7.png"),
  //バック
  back("assets/images/back.png");

  final String path;
  const Images(this.path);

  static String manzu(int i) {
    switch(i) {
      case 1: return Images.manzu_1.path;
      case 2: return Images.manzu_2.path;
      case 3: return Images.manzu_3.path;
      case 4: return Images.manzu_4.path;
      case 5: return Images.manzu_5.path;
      case 6: return Images.manzu_6.path;
      case 7: return Images.manzu_7.path;
      case 8: return Images.manzu_8.path;
      case 9: return Images.manzu_9.path;
      default: throw ArgumentError('Invalid manzu index: $i');
    }
  }
  static String pinzu(int i) {
    switch(i) {
      case 1: return Images.pinzu_1.path;
      case 2: return Images.pinzu_2.path;
      case 3: return Images.pinzu_3.path;
      case 4: return Images.pinzu_4.path;
      case 5: return Images.pinzu_5.path;
      case 6: return Images.pinzu_6.path;
      case 7: return Images.pinzu_7.path;
      case 8: return Images.pinzu_8.path;
      case 9: return Images.pinzu_9.path;
      default: throw ArgumentError("Invalid pinzu index: $i");
    }
  }
  static String souzu(int i) {
    switch(i) {
      case 1: return Images.souzu_1.path;
      case 2: return Images.souzu_2.path;
      case 3: return Images.souzu_3.path;
      case 4: return Images.souzu_4.path;
      case 5: return Images.souzu_5.path;
      case 6: return Images.souzu_6.path;
      case 7: return Images.souzu_7.path;
      case 8: return Images.souzu_8.path;
      case 9: return Images.souzu_9.path;
      default: throw ArgumentError("Invalid souzu index: $i");
    }
  }
  static String zihai(int i) {
    switch(i) {
      case 1: return Images.zihai_1.path;
      case 2: return Images.zihai_2.path;
      case 3: return Images.zihai_3.path;
      case 4: return Images.zihai_4.path;
      case 5: return Images.zihai_5.path;
      case 6: return Images.zihai_6.path;
      case 7: return Images.zihai_7.path;
      default: throw ArgumentError("Invalid zihai index: $i");
    }
  }
  static String backTile(int i) {
    switch(i) {
      case 1: return Images.back.path;
      default: throw ArgumentError("Invalid back index: $i");
    }
  }
}