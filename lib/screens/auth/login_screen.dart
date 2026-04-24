import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController    = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword     = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: Stack(
        children: [
          // Decorative bottom-right accent
          Positioned(
            bottom: 0,
            right: 0,
            child: Opacity(
              opacity: 0.03,
              child: Transform.rotate(
                angle: 0.785,
                child: Container(
                  width: 180,
                  height: 180,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),

          SafeArea(
            child: Column(
              children: [
                // Fixed Header
                Container(
                  height: 64,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: AppColors.creamWhite.withValues(alpha: 0.9),
                  ),
                  child: Text(
                    'Loom & Co',
                    style: GoogleFonts.newsreader(
                      fontSize: 28,
                      fontWeight: FontWeight.w500,
                      color: AppColors.primaryContainer,
                      fontStyle: FontStyle.italic,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),

                // Scrollable body
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.symmetric(horizontal: 28),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 48),

                        // Hero branding
                        Text(
                          'Loom & Co',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.newsreader(
                            fontSize: 32,
                            fontWeight: FontWeight.w500,
                            color: AppColors.primaryContainer,
                            letterSpacing: -0.3,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Welcome back to Loom & Co',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.inter(
                            fontSize: 13,
                            color: const Color(0xFF8A8A8E),
                            letterSpacing: 0.3,
                          ),
                        ),
                        const SizedBox(height: 40),

                        // Email field
                        _FieldLabel(label: 'Email'),
                        const SizedBox(height: 6),
                        _InputField(
                          controller: _emailController,
                          hint: 'email@example.com',
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 20),

                        // Password field
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const _FieldLabel(label: 'Password'),
                            GestureDetector(
                              onTap: () {},
                              child: Text(
                                'FORGOT PASSWORD',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.gold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 6),
                        _InputField(
                          controller: _passwordController,
                          hint: '••••••••',
                          obscureText: _obscurePassword,
                          suffixIcon: GestureDetector(
                            onTap: () => setState(
                                () => _obscurePassword = !_obscurePassword),
                            child: Icon(
                              _obscurePassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                              size: 18,
                              color: const Color(0xFF8A8A8E),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Login button
                        SizedBox(
                          height: 52,
                          child: ElevatedButton(
                            onPressed: () => context.go(AppRouter.main),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryContainer,
                              foregroundColor: AppColors.onPrimary,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              elevation: 0,
                            ),
                            child: Text(
                              'Login',
                              style: GoogleFonts.inter(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 36),

                        // Divider
                        Row(
                          children: [
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFE5DDD5),
                                thickness: 1,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Text(
                                'or continue with',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: const Color(0xFF8A8A8E),
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Divider(
                                color: const Color(0xFFE5DDD5),
                                thickness: 1,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 28),

                        // Google sign-in
                        SizedBox(
                          height: 52,
                          child: OutlinedButton(
                            onPressed: () {},
                            style: OutlinedButton.styleFrom(
                              side: const BorderSide(
                                  color: Color(0xFFE5DDD5), width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                _GoogleLogo(),
                                const SizedBox(width: 12),
                                Text(
                                  'Sign in with Google',
                                  style: GoogleFonts.inter(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.onSurface,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 48),

                        // Register link
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'NEW TO LOOM & CO?',
                              style: GoogleFonts.inter(
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xFF8A8A8E),
                                letterSpacing: 2.0,
                              ),
                            ),
                            const SizedBox(width: 6),
                            GestureDetector(
                              onTap: () => context.go(AppRouter.register),
                              child: Text(
                                'REGISTER',
                                style: GoogleFonts.inter(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primaryContainer,
                                  letterSpacing: 2.0,
                                  decoration: TextDecoration.underline,
                                  decorationColor: AppColors.primaryContainer
                                      .withValues(alpha: 0.4),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 40),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  final String label;
  const _FieldLabel({required this.label});

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: GoogleFonts.inter(
        fontSize: 10,
        fontWeight: FontWeight.w600,
        color: AppColors.onSurfaceVariant,
        letterSpacing: 2.0,
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String hint;
  final TextInputType keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;

  const _InputField({
    required this.controller,
    required this.hint,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.suffixIcon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: GoogleFonts.inter(fontSize: 14, color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: GoogleFonts.inter(
            fontSize: 14, color: const Color(0xFFADADAD)),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: const Color(0xFFF0EAE2),
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 18),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFE5DDD5), width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: Color(0xFFE5DDD5), width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide:
              const BorderSide(color: AppColors.primaryContainer, width: 1),
        ),
      ),
    );
  }
}

class _GoogleLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 20,
      height: 20,
      child: CustomPaint(painter: _GoogleLogoPainter()),
    );
  }
}

class _GoogleLogoPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint()..style = PaintingStyle.fill;

    // Blue
    paint.color = const Color(0xFF4285F4);
    path.moveTo(size.width, size.height * 0.51);
    path.lineTo(size.width, size.height * 0.51);
    canvas.drawPath(path, paint);

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);

    // Simplified: draw colored arcs for Google logo
    paint.color = const Color(0xFF4285F4);
    canvas.drawArc(rect, -1.57, 3.14, true, paint);
    paint.color = const Color(0xFF34A853);
    canvas.drawArc(rect, 0.52, 1.05, true, paint);
    paint.color = const Color(0xFFFBBC05);
    canvas.drawArc(rect, -2.62, 1.05, true, paint);
    paint.color = const Color(0xFFEA4335);
    canvas.drawArc(rect, -1.57, 1.05, true, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
