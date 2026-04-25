// import 'dart:io';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_easyloading/flutter_easyloading.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/src/root/get_material_app.dart';
//
//
// import 'Appconfig.dart';
// import 'Controllers/FranchiseModuleAuthControllers/ProfileController.dart';
// import 'View/Distribution Module/VerficationScreens/DistributorDetailsScreen.dart';
// import 'View/SplashScreen.dart';
//
//
//
// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await AppConfig.init();
//   HttpOverrides.global = DevHttpOverrides();
//   configLoading();
//   runApp(const MyApp());
// }
//
// class DevHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
//
// void configLoading() {
//   EasyLoading.instance
//     ..progressColor = Colors.black
//     ..maskType = EasyLoadingMaskType.black
//     ..displayDuration = const Duration(milliseconds: 2000)
//     ..indicatorType = EasyLoadingIndicatorType.circle
//     ..loadingStyle = EasyLoadingStyle.custom
//     ..indicatorSize = 30.0
//     ..radius = 20.0
//     ..backgroundColor = Colors.white
//     ..indicatorColor = Colors.black
//     ..textColor = Colors.black
//     ..userInteractions = false
//     ..dismissOnTap = false
//     ..maskColor = Colors.black.withOpacity(0.5)
//     ..toastPosition = EasyLoadingToastPosition.center
//     ..boxShadow = <BoxShadow>[];
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return GetMaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Franchaise',
//       theme: ThemeData(
//         fontFamily: 'Outfit',
//         colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF002D62)),
//         textTheme: const TextTheme(
//           bodyMedium: TextStyle(fontWeight: FontWeight.w400),
//         ),
//       ),
//       builder: EasyLoading.init(),
//       home: Splashscreen (),
//
//     );
//   }
// }


import 'dart:io';
import 'dart:math';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';

import 'Appconfig.dart';
import 'View/Distribution Module/VerficationScreens/DistributorDetailsScreen.dart';
import 'View/Franchaise Module/VerficationScreens/FranchiseDetailsScreen.dart';
import 'View/SplashScreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await AppConfig.init();
  HttpOverrides.global = DevHttpOverrides();

  configEasyLoading(); // EasyLoading setup

  runApp(const MyApp());
}

// ─────────────────────────────────────────────
// SSL override
// ─────────────────────────────────────────────
class DevHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
  }
}

// ─────────────────────────────────────────────
// EASYLOADING CONFIG
// ─────────────────────────────────────────────
void configEasyLoading() {
  EasyLoading.instance
    ..loadingStyle = EasyLoadingStyle.custom
    ..backgroundColor = const Color(0xFF111111)
    ..textColor = const Color(0xFFCCCCCC)
    ..maskColor = Colors.black.withOpacity(0.6)
    ..indicatorSize = 80
    ..radius = 20
    ..userInteractions = false
    ..dismissOnTap = false

  /// 🔥 THIS LINE FIXES YOUR CRASH
    ..indicatorColor = const Color(0xFFB71C1C)

    ..indicatorWidget = const MetaballLoadingWidget();
}

// ─────────────────────────────────────────────
// APP
// ─────────────────────────────────────────────
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Franchaise',
      theme: ThemeData(
        fontFamily: 'Outfit',
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF002D62)),
      ),
      navigatorKey: AppLoader.navigatorKey, // ✅ correct
      builder: EasyLoading.init(),
      home: const Splashscreen(),

    );
  }
}

// ─────────────────────────────────────────────
// APP LOADER (Folding Cube)
// ─────────────────────────────────────────────
class AppLoader {
  AppLoader._();

  static final GlobalKey<NavigatorState> navigatorKey =
  GlobalKey<NavigatorState>();

  static OverlayEntry? _entry;

  static void show({String message = 'Loading...'}) {
    if (_entry != null) return;

    final context = navigatorKey.currentContext;
    if (context == null) return;

    _entry = OverlayEntry(
      builder: (_) => _FoldingCubeOverlay(message: message),
    );

    Overlay.of(context).insert(_entry!);
  }

  static void hide() {
    _entry?.remove();
    _entry = null;
  }
}

// ─────────────────────────────────────────────
// OVERLAY UI
// ─────────────────────────────────────────────
class _FoldingCubeOverlay extends StatelessWidget {
  final String message;
  const _FoldingCubeOverlay({this.message = 'Loading...'});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.black.withOpacity(0.7),
      child: Center(
        child: Container(
          width: 180,
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: const Color(0xFF111111),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const FoldingCubeWidget(size: 70),
              const SizedBox(height: 20),
              Text(
                message,
                style: const TextStyle(
                  color: Color(0xFFBBBBBB),
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═════════════════════════════════════════════
// FOLDING CUBE WIDGET
// ═════════════════════════════════════════════
class FoldingCubeWidget extends StatefulWidget {
  final double size;
  const FoldingCubeWidget({super.key, this.size = 56});

  @override
  State<FoldingCubeWidget> createState() => _FoldingCubeWidgetState();
}

class _FoldingCubeWidgetState extends State<FoldingCubeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  final List<Animation<double>> _tiles = [];

  static const List<double> _delays = [0.0, 0.25, 0.75, 0.50];

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat();

    for (int i = 0; i < 4; i++) {
      final start = _delays[i];
      final end = (start + 0.50).clamp(0.0, 1.0);
      _tiles.add(
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: _ctrl,
            curve: Interval(start, end, curve: Curves.easeInOut),
          ),
        ),
      );
    }
  }



  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _ctrl,
      builder: (_, __) => SizedBox(
        width: widget.size,
        height: widget.size,
        child: CustomPaint(
          painter: _FoldingCubePainter(
            t0: _tiles[0].value,
            t1: _tiles[1].value,
            t2: _tiles[2].value,
            t3: _tiles[3].value,
            size: widget.size,
          ),
        ),
      ),
    );
  }
}



//  CUSTOM PAINTER
// ═════════════════════════════════════════════════════════════
class _FoldingCubePainter extends CustomPainter {
  final double t0, t1, t2, t3, size;

  const _FoldingCubePainter({
    required this.t0,
    required this.t1,
    required this.t2,
    required this.t3,
    required this.size,
  });

  static const Color _red     = Color(0xFFB71C1C); // 🔥 rich dark red
  static const Color _darkRed = Color(0xFF7F0000); // deeper red
  static const Color _deepRed = Color(0xFF3E0000); // very dark red
  static const Color _white   = Color(0xFFFFFFFF);
  static const Color _border  = Color(0xff2B2B2B); // ✅ your choice

  static const List<Color> _faceColors = [
    _red, _darkRed, _darkRed, _red,
  ];

  @override
  void paint(Canvas canvas, Size canvasSize) {
    final gap  = size * 0.04;
    final tile = (size - gap) / 2;

    final List<Offset> origins = [
      Offset(0,          0),
      Offset(tile + gap, 0),
      Offset(0,          tile + gap),
      Offset(tile + gap, tile + gap),
    ];

    final List<double> ts = [t0, t1, t2, t3];

    // Draw folded tiles behind flat tiles
    final order = [0, 1, 2, 3]
      ..sort((a, b) => ts[b].compareTo(ts[a]));

    for (final idx in order) {
      _drawTile(
        canvas:   canvas,
        origin:   origins[idx],
        tileSize: tile,
        t:        ts[idx],
        color:    _faceColors[idx],
        index:    idx,
      );
    }
  }

  void _drawTile({
    required Canvas canvas,
    required Offset origin,
    required double tileSize,
    required double t,
    required Color  color,
    required int    index,
  }) {
    final scaleY = cos(t * pi).abs();
    final scaleX = 1.0 - t * 0.18;
    if (scaleY < 0.01) return;

    final brightness = (1.0 - t * 0.65).clamp(0.0, 1.0);
    final faceColor  = Color.lerp(color, _deepRed, t * 0.6)!
        .withOpacity(brightness);

    final pivot = Offset(
      origin.dx + (index == 0 || index == 2 ? tileSize : 0),
      origin.dy + (index == 0 || index == 1 ? tileSize : 0),
    );

    final w  = tileSize * scaleX;
    final h  = tileSize * scaleY;
    final sx = (index == 0 || index == 2) ? -1.0 : 1.0;
    final sy = (index == 0 || index == 1) ? -1.0 : 1.0;

    final tl = pivot + Offset(sx * w, sy * h);
    final tr = pivot + Offset(0,      sy * h);
    final bl = pivot + Offset(sx * w, 0);
    final br = pivot;

    final path = Path()
      ..moveTo(tl.dx, tl.dy)
      ..lineTo(tr.dx, tr.dy)
      ..lineTo(br.dx, br.dy)
      ..lineTo(bl.dx, bl.dy)
      ..close();

    // Face
    canvas.drawPath(path, Paint()..color = faceColor);

    // Top sheen
    if (scaleY > 0.15) {
      final sheenH  = h * 0.28 * scaleY;
      final sheenPath = Path()
        ..moveTo(tl.dx, tl.dy)
        ..lineTo(tr.dx, tr.dy)
        ..lineTo((pivot + Offset(0,      sy * sheenH)).dx,
            (pivot + Offset(0,      sy * sheenH)).dy)
        ..lineTo((pivot + Offset(sx * w, sy * sheenH)).dx,
            (pivot + Offset(sx * w, sy * sheenH)).dy)
        ..close();
      canvas.drawPath(
        sheenPath,
        Paint()..color = _white.withOpacity(0.10 * scaleY),
      );
    }

    // Border
    canvas.drawPath(
      path,
      Paint()
        ..color       = _border.withOpacity(0.6 + 0.4 * scaleY)
        ..style       = PaintingStyle.stroke
        ..strokeWidth = 0.8,
    );

    // Red accent on pivot edge
    if (scaleY > 0.05) {
      canvas.drawLine(
        br,
        (index == 0 || index == 2) ? tr : bl,
        Paint()
          ..color       = _red.withOpacity(0.45 * scaleY)
          ..strokeWidth = 1.2
          ..strokeCap   = StrokeCap.round,
      );
    }
  }

  @override
  bool shouldRepaint(_FoldingCubePainter old) =>
      old.t0 != t0 || old.t1 != t1 || old.t2 != t2 || old.t3 != t3;
}


// ═════════════════════════════════════════════
// METABALL LOADING WIDGET (UNCHANGED UI)
// ═════════════════════════════════════════════
const Color kBg = Color(0xFF111111);
const Color kRed = Color(0xFFE24B4A);
const Color kDark = Color(0xFFA32D2D);
const Color kWhite = Color(0xFFFFFFFF);

class MetaballLoadingWidget extends StatefulWidget {
  final double size;
  const MetaballLoadingWidget({super.key, this.size = 90});

  @override
  State<MetaballLoadingWidget> createState() =>
      _MetaballLoadingWidgetState();
}

class _MetaballLoadingWidgetState extends State<MetaballLoadingWidget>
    with TickerProviderStateMixin {
  late AnimationController _mainCtrl;
  late AnimationController _pulseCtrl;
  late AnimationController _rotCtrl;

  late Animation<double> _moveAnim;
  late Animation<double> _pulseAnim;
  late Animation<double> _rotAnim;

  @override
  void initState() {
    super.initState();

    _mainCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    )..repeat(reverse: true);

    _moveAnim = Tween<double>(begin: -1.0, end: 1.0).animate(
      CurvedAnimation(parent: _mainCtrl, curve: Curves.easeInOut),
    );

    _pulseCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.55, end: 1.0).animate(
      CurvedAnimation(parent: _pulseCtrl, curve: Curves.easeInOut),
    );

    _rotCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 4000),
    )..repeat();

    _rotAnim = Tween<double>(begin: 0, end: 2 * pi).animate(_rotCtrl);
  }

  @override
  void dispose() {
    _mainCtrl.dispose();
    _pulseCtrl.dispose();
    _rotCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size * 0.6,
      child: AnimatedBuilder(
        animation: Listenable.merge([_moveAnim, _pulseAnim, _rotAnim]),
        builder: (_, __) {
          return CustomPaint(
            painter: _MetaballPainter(
              moveT: _moveAnim.value,
              pulseT: _pulseAnim.value,
              rotT: _rotAnim.value,
            ),
          );
        },
      ),
    );
  }
}

// Painter unchanged (your UI intact)
class _MetaballPainter extends CustomPainter {
  final double moveT;
  final double pulseT;
  final double rotT;

  _MetaballPainter({
    required this.moveT,
    required this.pulseT,
    required this.rotT,
  });

  static const double _rBig = 14.0;
  static const double _rCenter = 9.0;
  static const double _spread = 22.0;

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    final leftX = cx - _spread + moveT * _spread * 0.55;
    final rightX = cx + _spread - moveT * _spread * 0.55;
    final centerR = _rCenter * pulseT;

    final leftO = Offset(leftX, cy);
    final rightO = Offset(rightX, cy);
    final centO = Offset(cx, cy);

    canvas.drawCircle(leftO, _rBig, Paint()..color = kRed);
    canvas.drawCircle(rightO, _rBig, Paint()..color = kDark);
    canvas.drawCircle(
      centO,
      centerR,
      Paint()..color = kWhite.withOpacity(0.85 * pulseT),
    );
  }

  @override
  bool shouldRepaint(_MetaballPainter old) =>
      old.moveT != moveT ||
          old.pulseT != pulseT ||
          old.rotT != rotT;
}