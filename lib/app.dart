import 'package:flutter/material.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _walletSlideAnim;
  late final Animation<double> _walletOpacityAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _walletSlideAnim = Tween<Offset>(
      begin: const Offset(0, -0.5),
      end: const Offset(0, 0.2),
    ).animate(curve);
    _walletOpacityAnim = Tween<double>(begin: 0, end: 1).animate(curve);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          final t = Curves.easeInOut.transform(_controller.value);
          final topColor = Color.lerp(
            Colors.grey.shade800,
            Colors.yellow.shade200,
            t,
          )!;
          final bottomColor = Color.lerp(
            Colors.grey.shade900,
            Colors.grey.shade900,
            t,
          )!;

          return Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [topColor, bottomColor],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: child,
          );
        },
        child: Center(
          child: FadeTransition(
            opacity: _walletOpacityAnim,
            child: SlideTransition(
              position: _walletSlideAnim,
              child: Image.asset(
                'assets/images/wallet.png',
                width: 120,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
