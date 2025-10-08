import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mahjong/images.dart';
import 'package:mahjong/page_a.dart';
import 'package:mahjong/page_b.dart';
import 'package:mahjong/select_page.dart';




Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.landscapeLeft,
    DeviceOrientation.landscapeRight,
  ]);

  const app = MaterialApp(home: Home());
  const scope = ProviderScope(child: app);
  runApp(scope);
}



class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return SelectPage();
  }
}