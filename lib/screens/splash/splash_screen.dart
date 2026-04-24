import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _loadingAnim;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2200),
    )..forward();

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        context.go(AppRouter.login);
      }
    });

    _fadeAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.4, curve: Curves.easeIn),
    );

    _loadingAnim = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryContainer,
      body: Stack(
        children: [
          // Subtle background texture overlay
          Positioned.fill(
            child: Opacity(
              opacity: 0.06,
              child: Container(
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage(
                      'https://lh3.googleusercontent.com/aida-public/AB6AXuCTrvPUyk5CNOrNWpnEHhGa0JYw3KLL8I2hOR9s6jMfUZRRUPs_a1UregImfvt277FzPTzN0YLO4ShsNK6olMt2LcQtUxCFHcewmewKcnrp96it0etsGcRWDu8NDyu1vH8yEgbqedgeUbMHUWWXVo1_iBGnPyaCkXWP3O41nfsbHuxgajt-Rl13V7B9uLs3Q4Y3LnfLxYSfVpLb8rzO4bmBIV2yVuTVB9zgsVFEXfhcnR95B6F5_w9-2OVjeEUpjeqIizTsaf9ga5h3',
                    ),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),

          // Center branding
          Center(
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Loom & Co',
                    style: GoogleFonts.newsreader(
                      fontSize: 42,
                      fontWeight: FontWeight.w500,
                      color: AppColors.creamWhite,
                      letterSpacing: -0.5,
                      height: 1.2,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'WEAR YOUR STORY',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.gold,
                      letterSpacing: 3.2,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Loading indicator
          Positioned(
            bottom: 96,
            left: 0,
            right: 0,
            child: Center(
              child: SizedBox(
                width: 192,
                height: 1,
                child: Stack(
                  children: [
                    // Track
                    Container(
                      color: Colors.white.withValues(alpha: 0.1),
                    ),
                    // Animated gold bar
                    AnimatedBuilder(
                      animation: _loadingAnim,
                      builder: (_, _) => FractionallySizedBox(
                        widthFactor: _loadingAnim.value,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.gold,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.gold.withValues(alpha: 0.6),
                                blurRadius: 8,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Footer
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: FadeTransition(
              opacity: _fadeAnim,
              child: Center(
                child: Opacity(
                  opacity: 0.3,
                  child: Text(
                    'EST. 2024',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white,
                      letterSpacing: 4.8,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
