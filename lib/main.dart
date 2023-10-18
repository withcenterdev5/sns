import 'package:fireflutter/fireflutter.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:sns/firebase_options.dart';
import 'package:sns/widgets/init.dart';
import 'package:sns/router/router.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  static const String routeName = '/';
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      FireFlutterService.instance.init(context: router.routerDelegate.navigatorKey.currentContext!);
    });
    mainInit();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: ),
        // colorScheme: const ColorScheme(
        //   brightness: Brightness.light,
        //   primary: Color(0x006750a4),
        //   onPrimary: Color(0x00ffffff),
        //   primaryContainer: Color(0x00eaddff),
        //   secondary: Color(0x005056a9),
        //   onSecondary: Color(0x00ffffff),
        //   secondaryContainer: Color(0x00e0e0ff),
        //   tertiary: Color(0x007e5260),
        //   tertiaryContainer: Color(0x00ffd9e3),
        //   onTertiary: Color(0x00ffffff),
        //   onTertiaryContainer: Color(0x0031101d),
        //   error: Color(0x00ba1a1a),
        //   onError: Color(0x00ffffff),
        //   background: Color(0x00ffdad6),
        //   onBackground: Color(0x001c1b1e),
        //   surface: Color(0x00fffbff),
        //   onSurface: Color(0x001c1b1e),
        // ),
        textTheme: TextTheme(
          headlineMedium: GoogleFonts.ptSerif(
            fontSize: sizeXl,
          ),
          labelMedium: GoogleFonts.ptSerif(
            fontSize: sizeSm,
          ),
        ),
        useMaterial3: true,
      ),
      routerConfig: router,
    );
  }
}
