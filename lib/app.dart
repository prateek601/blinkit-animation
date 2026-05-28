import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with TickerProviderStateMixin {
  late final AnimationController _controller;

  late final Animation<Offset> _walletSlideAnim;
  late final Animation<double> _walletOpacityAnim;

  late AnimationController _lottieController;

  late final AnimationController _walletSecondUpwardMovementController;
  late final Animation<Offset> _walletSecondUpwardMovementAnim;

  // text animation
  late final Animation<Offset> _text1SlideAnim;
  late final Animation<double> _text1OpacityAnim;
  late final Animation<Offset> _text2SlideAnim;
  late final Animation<double> _text2OpacityAnim;

  late final AnimationController _thirdAnimationController;
  late final Animation<Alignment> _alignmentAnim; 

  bool _showLottie = false;

  @override
  void initState() {
    super.initState();
    _thirdAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _walletSecondUpwardMovementController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _controller = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );
    final curve = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _walletSlideAnim = Tween<Offset>(
      begin: const Offset(0, -0.6),
      end: const Offset(0, 0.2),
    ).animate(curve);
    _walletOpacityAnim = Tween<double>(begin: 0, end: 1).animate(curve);
    _controller.forward();

    _lottieController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() => _showLottie = true);
        _lottieController.forward(); // starts Lottie from frame 0
        Future.delayed(const Duration(seconds: 1), () {
          if (!mounted) return;
          _walletSecondUpwardMovementController.forward();
        });
      }
    });
    _walletSecondUpwardMovementAnim = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: const Offset(0, -0.5),
    ).animate(CurvedAnimation(parent: _walletSecondUpwardMovementController, curve: Interval(0, 0.5, curve: Curves.easeInOut)));

    _text1SlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, -0.4),
    ).animate(CurvedAnimation(parent: _walletSecondUpwardMovementController, curve: Interval(0.5, 0.75, curve: Curves.easeInOut)));
    _text1OpacityAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _walletSecondUpwardMovementController, curve: Interval(0.5, 0.75, curve: Curves.easeInOut)));
    _text2SlideAnim = Tween<Offset>(
      begin: const Offset(0, 0.5),
      end: const Offset(0, -0.43),
    ).animate(CurvedAnimation(parent: _walletSecondUpwardMovementController, curve: Interval(0.75, 1, curve: Curves.easeInOut)));
    _text2OpacityAnim = Tween<double>(begin: 0, end: 1).animate(CurvedAnimation(parent: _walletSecondUpwardMovementController, curve: Interval(0.75, 1, curve: Curves.easeInOut)));

    _alignmentAnim =
        Tween<Alignment>(
          begin: Alignment.center,
          end: Alignment(0, -0.7),
        ).animate(
          CurvedAnimation(
            parent: _thirdAnimationController,
            curve: Interval(0, 0.4, curve: Curves.easeInOut),
          ),
        );

    _walletSecondUpwardMovementController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          _thirdAnimationController.forward();
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    _walletSecondUpwardMovementController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          AnimatedBuilder(
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
            child: AlignTransition(
              alignment: _alignmentAnim,
              child: Column(
                mainAxisAlignment: .center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  FadeTransition(
                    opacity: _walletOpacityAnim,
                    child: SlideTransition(
                      position: _walletSecondUpwardMovementAnim,
                      child: SlideTransition(
                        position: _walletSlideAnim,
                        child: Image.asset('assets/images/wallet.png', width: 120),
                      ),
                    ),
                  ),
                  FadeTransition(
                    opacity: _text1OpacityAnim,
                    child: SlideTransition(
                      position: _text1SlideAnim,
                      child: Text('blinkit', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                  FadeTransition(
                    opacity: _text2OpacityAnim,
                    child: SlideTransition(
                      position: _text2SlideAnim,
                      child: Text('MONEY', style: TextStyle(fontSize: 70, fontWeight: FontWeight.bold, color: Colors.white)),
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (_showLottie)
            Lottie.asset(
              'assets/lottie/confetti.json',
              controller: _lottieController,
              width: double.infinity,
              height: double.infinity,
            ),
        ],
      ),
    );
  }
}
