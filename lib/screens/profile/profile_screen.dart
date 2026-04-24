import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  static const _menuItems = [
    (icon: Icons.person_outline, label: 'Edit Profile'),
    (icon: Icons.local_shipping_outlined, label: 'My Orders'),
    (icon: Icons.favorite_border, label: 'Wishlist'),
    (icon: Icons.location_on_outlined, label: 'Address Book'),
    (icon: Icons.settings_outlined, label: 'Settings'),
    (icon: Icons.help_outline, label: 'Help & Support'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 24),

                    // Page title
                    Text(
                      'My Profile',
                      style: GoogleFonts.newsreader(
                        fontSize: 30,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                        letterSpacing: -0.3,
                      ),
                    ),
                    const SizedBox(height: 20),

                    // Profile header card
                    _ProfileCard(),
                    const SizedBox(height: 32),

                    // Menu items
                    ...List.generate(_menuItems.length, (i) {
                      final item = _menuItems[i];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: _MenuItem(
                          icon: item.icon,
                          label: item.label,
                          onTap: () {},
                        ),
                      );
                    }),

                    const SizedBox(height: 16),

                    // Logout
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 16),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            Icon(Icons.logout,
                                size: 22, color: AppColors.error),
                            const SizedBox(width: 16),
                            Text(
                              'Logout',
                              style: GoogleFonts.inter(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: AppColors.error,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      color: AppColors.creamWhite.withValues(alpha: 0.9),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Icon(Icons.menu, color: AppColors.primaryContainer, size: 24),
          Text(
            'Loom & Co',
            style: GoogleFonts.newsreader(
              fontSize: 24,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              color: AppColors.primaryContainer,
            ),
          ),
          Icon(Icons.shopping_bag_outlined,
              color: AppColors.primaryContainer, size: 24),
        ],
      ),
    );
  }
}

// ─── Profile Card ─────────────────────────────────────────────────────────────

class _ProfileCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primaryContainer, AppColors.primary],
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Stack(
        children: [
          // Decorative radial highlight
          Positioned(
            top: -20,
            right: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withValues(alpha: 0.07),
              ),
            ),
          ),

          Row(
            children: [
              // Avatar with gold ring
              Container(
                width: 80,
                height: 80,
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: AppColors.gold.withValues(alpha: 0.45),
                    width: 2,
                  ),
                ),
                child: ClipOval(
                  child: Image.network(
                    'https://lh3.googleusercontent.com/aida-public/AB6AXuD7iSS_ExdJ4C0oZSy_kwbNamvZHD1QtzuRvYiSb6MqxE4Z3sVyadZiHfHNCvxztEe55P_gl1m-GGuVf0ICJzPtKqT0pPnXXjr8I_XNYXUYS5NO2ccQpeOkfxQPWUS__d8xngBTJ_ShT0ctCcf1ktNDmcAZAH4dBIQauixqVrLwHMZAUe84lx3BEunf3kQj5fkrPI_5dLzeWS0UFkGbGwvbhywY5SZrvDdHw-6gRtO-OWk1rL9_LRaHX8yYv7FfM_vZxV5UuE8L70gF',
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) => Container(
                      color: AppColors.primaryContainer,
                      child: const Icon(Icons.person,
                          size: 36, color: Colors.white54),
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 20),

              // Name & email
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Eleanor Vance',
                      style: GoogleFonts.newsreader(
                        fontSize: 22,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'eleanor.vance@loomandco.com',
                      style: GoogleFonts.inter(
                        fontSize: 12,
                        color: AppColors.gold,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Menu Item ────────────────────────────────────────────────────────────────

class _MenuItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _MenuItem({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(icon, size: 22, color: AppColors.primaryContainer),
            const SizedBox(width: 16),
            Expanded(
              child: Text(
                label,
                style: GoogleFonts.inter(
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
            ),
            Icon(Icons.chevron_right,
                size: 20, color: AppColors.outlineVariant),
          ],
        ),
      ),
    );
  }
}

