import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:prateek/widgets/primary_button.dart';
import 'package:prateek/widgets/wallet_feature_card.dart';
import 'package:prateek/widgets/claim_gift_card.dart';
import 'package:prateek/widgets/custom_icon_button.dart';

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
  late final Animation<double> _card1FadeAnim;
  late final Animation<double> _card2FadeAnim;
  late final Animation<double> _card3FadeAnim;
  late final Animation<double> _settingsIconFadeAnim;

  bool _showLottie = false;
  bool _animationCompleted = false;

  @override
  void initState() {
    super.initState();
    _thirdAnimationController = AnimationController(
      duration: const Duration(milliseconds: 1800),
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
      begin: const Offset(0, -0.2),
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
    _walletSecondUpwardMovementAnim =
        Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: const Offset(0, -0.5),
        ).animate(
          CurvedAnimation(
            parent: _walletSecondUpwardMovementController,
            curve: Interval(0, 0.5, curve: Curves.easeInOut),
          ),
        );

    _text1SlideAnim =
        Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: const Offset(0, -0.4),
        ).animate(
          CurvedAnimation(
            parent: _walletSecondUpwardMovementController,
            curve: Interval(0.5, 0.75, curve: Curves.easeInOut),
          ),
        );
    _text1OpacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _walletSecondUpwardMovementController,
        curve: Interval(0.5, 0.75, curve: Curves.easeInOut),
      ),
    );
    _text2SlideAnim =
        Tween<Offset>(
          begin: const Offset(0, 0.5),
          end: const Offset(0, -0.43),
        ).animate(
          CurvedAnimation(
            parent: _walletSecondUpwardMovementController,
            curve: Interval(0.75, 1, curve: Curves.easeInOut),
          ),
        );
    _text2OpacityAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _walletSecondUpwardMovementController,
        curve: Interval(0.75, 1, curve: Curves.easeInOut),
      ),
    );

    _alignmentAnim =
        Tween<Alignment>(
          begin: Alignment.center,
          end: Alignment(0, -0.65),
        ).animate(
          CurvedAnimation(
            parent: _thirdAnimationController,
            curve: Interval(0, 0.5, curve: Curves.easeInOut),
          ),
        );

    _card1FadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _thirdAnimationController,
        curve: Interval(0.3, 0.5, curve: Curves.easeInOut),
      ),
    );
    _card2FadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _thirdAnimationController,
        curve: Interval(0.5, 0.7, curve: Curves.easeInOut),
      ),
    );
    _card3FadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _thirdAnimationController,
        curve: Interval(0.7, 0.9, curve: Curves.easeInOut),
      ),
    );
    _settingsIconFadeAnim = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _thirdAnimationController,
        curve: Interval(0.9, 1, curve: Curves.easeInOut),
      ),
    );
    _walletSecondUpwardMovementController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          _thirdAnimationController.forward();
        });
      }
    });
    _thirdAnimationController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 1), () {
          setState(() {
            _animationCompleted = true;
          });
        });
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _lottieController.dispose();
    _walletSecondUpwardMovementController.dispose();
    _thirdAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          TweenAnimationBuilder(
            tween: Tween(begin: 0.0, end: _animationCompleted ? 1.0 : 0.0),
            duration: const Duration(milliseconds: 100),
            curve: Curves.easeInOut,
            builder: (context, value, child) {
              return Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Color.lerp(Color(0xFF3D3500), Color(0xFF2E2A1A), value)!,
                      Color.lerp(Color(0xFF1A1500), Color(0xFF1A1814), value)!,
                      Color.lerp(Color(0xFF000000), Color(0xFF0D0D0D), value)!,
                    ],
                    stops: [0.0, 0.4, 1.0],
                  ),
                ),
                child: child,
              );
            },
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
                children: [
                  Positioned(
                    top: 30,
                    right: 0,
                    left: 0,
                    child: Expanded(
                      child: Row(
                        mainAxisAlignment: .spaceBetween,
                        children: [
                          CustomIconButton(
                            icon: Icons.keyboard_arrow_left_rounded,
                          ),
                          FadeTransition(
                            opacity: _settingsIconFadeAnim,
                            child: CustomIconButton(icon: Icons.settings),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
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
                                child: Image.asset(
                                  'assets/images/wallet.png',
                                  width: 100,
                                ),
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _text1OpacityAnim,
                            child: SlideTransition(
                              position: _text1SlideAnim,
                              child: Text(
                                'blinkit',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                          FadeTransition(
                            opacity: _text2OpacityAnim,
                            child: SlideTransition(
                              position: _text2SlideAnim,
                              child: Text(
                                'MONEY',
                                style: TextStyle(
                                  fontSize: 66,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        FadeTransition(
                          opacity: _card1FadeAnim,
                          child: WalletFeatureCard(
                            image: "assets/images/wallet.png",
                            title: "Single tap payments",
                            body:
                                "Enjoy Seamless payments without the wait for OTPs",
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeTransition(
                          opacity: _card2FadeAnim,
                          child: WalletFeatureCard(
                            image: "assets/images/wallet.png",
                            title: "Zero Failures",
                            body:
                                "Zero payment failures ensures you never miss an order",
                          ),
                        ),
                        const SizedBox(height: 8),
                        FadeTransition(
                          opacity: _card3FadeAnim,
                          child: WalletFeatureCard(
                            image: "assets/images/wallet.png",
                            title: "Real-time refunds",
                            body:
                                "No need to wait for refunds. Blinkit money refunds are instant!",
                          ),
                        ),
                        AnimatedOpacity(
                          duration: Duration(milliseconds: 200),
                          opacity: _animationCompleted ? 1 : 0,
                          child: Column(
                            children: [
                              const SizedBox(height: 8),
                              PrimaryButton(title: "Add Money"),
                              const SizedBox(height: 16),
                              ClaimGiftCard(),
                              SizedBox(height: 30),
                              Text(
                                "Enjoy seamless\n one tap payments",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.w700,
                                  color: Colors.white24,
                                  height: 1,
                                ),
                              ),
                              const SizedBox(height: 40)
                            ],
                          ),
                        ),
                      ],
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
