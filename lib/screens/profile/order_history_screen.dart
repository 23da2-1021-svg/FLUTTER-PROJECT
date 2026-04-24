import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

enum _OrderStatus { processing, delivered, cancelled }

class _Order {
  final String id;
  final String date;
  final _OrderStatus status;
  final String productName;
  final double total;
  final List<String> imageUrls;

  const _Order({
    required this.id,
    required this.date,
    required this.status,
    required this.productName,
    required this.total,
    required this.imageUrls,
  });
}

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  int _selectedTab = 0;
  static const _tabs = ['All', 'Active', 'Delivered', 'Cancelled'];

  static const _orders = [
    _Order(
      id: '#12845',
      date: 'October 24, 2023',
      status: _OrderStatus.processing,
      productName: 'Velvet Evening Set & 2 others',
      total: 1420.00,
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuDgeXUQ7o0ne08k1MIo1YRSJ9dQJB5heYdtqZhjNf-U6KqdSjqdJtpvnuxeZz82IG9bYQCIaXI7iy-rCtPVLzEDIoF3sHOSRQoxSHhkK_989GuoHuMhyci9_q_HFf7KP2iI4b1J3ikju12NtQd6tYeft1ytRRKgdK3upXa5PDy2WxnpK0IKRnu358DP04EDQrXnBcIagJfHx6mNKXRsIwHXU6XNucvM7DHBAUPNJoNQ7DboEsZ_VRr2iswnhFplUwG7I2J2WK1WzZrF',
        'https://lh3.googleusercontent.com/aida-public/AB6AXuArKiLVfWEWW-gc-eXodzz8rsbRv9jMC4uF7snIPujO8050EUm0wlMlKof6H8SEphpl4crrid19K1iFpz5ZVFrkxdxtufXblcphHxk6eHHML338Ui1fDp7xWIDG6fTzqoMQ3skZQuEqRRKb8ZbOnLM1iad4vLhpdReGsKfYZcuRAvsEkA7At_zELuih7mjQ85NXl80_YvUWcLt21QJq2JpFV6_llwb5QITlFpnPhA1sFoluDC2DMwTMhKTWEX-rBtsP76QxYVQZG7BR',
      ],
    ),
    _Order(
      id: '#12431',
      date: 'October 12, 2023',
      status: _OrderStatus.delivered,
      productName: '24k Heritage Chain',
      total: 890.00,
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuBB3Sg91Jyc2i9tPHKjFAC-rRqE2nWkdoS7CtQj83YdFZy3kmTKhi19RZiqrMkrRssGbB2MOby13nNqlEVowQfOpb0aeZi8cOVOgACFpDi8e_LyNP7y79PvkvngbcaF7JmtGL0513_TaVoJ8Z4VTiVPFFg3VcY9ixXMR5SrDJYM4d3Cv0pxmx5s7GpSPBp0ln6R1fse6tw2EmC8FQPnYbk2L2zXkqG0QPjagya2FAtD6K5LeAvy8ywXhgyhwwPSFGB0e4Un-hfOtKXs',
      ],
    ),
    _Order(
      id: '#12345',
      date: 'September 28, 2023',
      status: _OrderStatus.cancelled,
      productName: 'Maison Noir Eau de Parfum',
      total: 340.00,
      imageUrls: [
        'https://lh3.googleusercontent.com/aida-public/AB6AXuCwWNpuCRDZ9qFVv3nJYy7nXt56l2mI9MLC1huA-OSE3Q0LLpr4AgHlJM5Jhh9kZEypezazUkpe3ZfEyVIFGo-qjI30o7TtyyJcRdQCv4Cm-X7IQ1-iZ0b_vfmsFjochpbAOagKl64KfWXRENOHKeah2lBU5DPx6dq-8x3-3MDjpGSTsYVHvTjApIPxnYNS9DpDfwJils-bkPR3tRoqF4mg5MDRmyKW45Inw-pJwgFlR49t8TPcDx8Gbd7zHWnpbf27Mhu7k1pNzaEJ',
      ],
    ),
  ];

  List<_Order> get _filtered {
    switch (_selectedTab) {
      case 1:
        return _orders
            .where((o) => o.status == _OrderStatus.processing)
            .toList();
      case 2:
        return _orders
            .where((o) => o.status == _OrderStatus.delivered)
            .toList();
      case 3:
        return _orders
            .where((o) => o.status == _OrderStatus.cancelled)
            .toList();
      default:
        return _orders;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AppBar(),

            Expanded(
              child: CustomScrollView(
                slivers: [
                  // Page title
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 28, 24, 0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'My Orders',
                            style: GoogleFonts.newsreader(
                              fontSize: 36,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: AppColors.primary,
                              letterSpacing: -0.5,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'Track and manage your curated collection',
                            style: GoogleFonts.inter(
                              fontSize: 13,
                              color: AppColors.onSurfaceVariant
                                  .withValues(alpha: 0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Filter tabs
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(24, 24, 0, 0),
                      child: SizedBox(
                        height: 48,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: _tabs.length,
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 24),
                          itemBuilder: (_, i) {
                            final active = i == _selectedTab;
                            return GestureDetector(
                              onTap: () =>
                                  setState(() => _selectedTab = i),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _tabs[i],
                                    style: GoogleFonts.inter(
                                      fontSize: 14,
                                      fontWeight: active
                                          ? FontWeight.w600
                                          : FontWeight.w400,
                                      color: active
                                          ? AppColors.onSurface
                                          : AppColors.onSurfaceVariant,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  AnimatedContainer(
                                    duration:
                                        const Duration(milliseconds: 200),
                                    height: 2,
                                    width: active ? 40 : 0,
                                    decoration: BoxDecoration(
                                      color: AppColors.primary,
                                      borderRadius:
                                          BorderRadius.circular(2),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  // Divider
                  SliverToBoxAdapter(
                    child: Divider(
                      color: AppColors.surfaceContainerHigh,
                      height: 1,
                    ),
                  ),

                  // Order cards
                  SliverPadding(
                    padding: const EdgeInsets.fromLTRB(24, 24, 24, 40),
                    sliver: _filtered.isEmpty
                        ? SliverFillRemaining(
                            child: _EmptyState(tab: _tabs[_selectedTab]),
                          )
                        : SliverList(
                            delegate: SliverChildBuilderDelegate(
                              (_, i) => Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 16),
                                child: _OrderCard(order: _filtered[i]),
                              ),
                              childCount: _filtered.length,
                            ),
                          ),
                  ),
                ],
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

// ─── Order Card ───────────────────────────────────────────────────────────────

class _OrderCard extends StatelessWidget {
  final _Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final cancelled = order.status == _OrderStatus.cancelled;

    return Opacity(
      opacity: cancelled ? 0.75 : 1.0,
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: AppColors.surfaceContainerLow,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header row
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'ORDER ID',
                      style: GoogleFonts.inter(
                        fontSize: 9,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurfaceVariant
                            .withValues(alpha: 0.6),
                        letterSpacing: 2.0,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.id,
                      style: GoogleFonts.newsreader(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      order.date,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                _StatusBadge(status: order.status),
              ],
            ),
            const SizedBox(height: 20),

            // Product thumbnails + name
            Row(
              children: [
                _ThumbnailStack(
                  urls: order.imageUrls,
                  greyscale: cancelled,
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    order.productName,
                    style: GoogleFonts.inter(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurface,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Total row
            Divider(
              color: AppColors.outlineVariant.withValues(alpha: 0.25),
              height: 1,
            ),
            const SizedBox(height: 14),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Total',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
                Text(
                  '\$${order.total.toStringAsFixed(2)}',
                  style: GoogleFonts.newsreader(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
              ],
            ),

            // Track button (only for processing)
            if (order.status == _OrderStatus.processing) ...[
              const SizedBox(height: 14),
              SizedBox(
                width: double.infinity,
                height: 44,
                child: OutlinedButton(
                  onPressed: () {},
                  style: OutlinedButton.styleFrom(
                    side: BorderSide(
                      color: AppColors.primaryContainer
                          .withValues(alpha: 0.4),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'TRACK ORDER',
                    style: GoogleFonts.inter(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: AppColors.primaryContainer,
                      letterSpacing: 1.5,
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ─── Status Badge ─────────────────────────────────────────────────────────────

class _StatusBadge extends StatelessWidget {
  final _OrderStatus status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    late Color bg;
    late Color fg;
    late String label;

    switch (status) {
      case _OrderStatus.processing:
        bg = AppColors.secondaryContainer;
        fg = const Color(0xFF5A4500);
        label = 'Processing';
      case _OrderStatus.delivered:
        bg = const Color(0xFFE8F5E9);
        fg = const Color(0xFF2E7D32);
        label = 'Delivered';
      case _OrderStatus.cancelled:
        bg = const Color(0xFFFFEBEE);
        fg = const Color(0xFFC62828);
        label = 'Cancelled';
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        label.toUpperCase(),
        style: GoogleFonts.inter(
          fontSize: 9,
          fontWeight: FontWeight.w700,
          color: fg,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}

// ─── Thumbnail Stack ──────────────────────────────────────────────────────────

class _ThumbnailStack extends StatelessWidget {
  final List<String> urls;
  final bool greyscale;
  const _ThumbnailStack({required this.urls, this.greyscale = false});

  @override
  Widget build(BuildContext context) {
    final shown = urls.take(2).toList();
    final extra = urls.length - 2;

    return SizedBox(
      width: shown.length * 48.0 + (extra > 0 ? 48 : 0),
      height: 64,
      child: Stack(
        children: [
          ...List.generate(shown.length, (i) {
            return Positioned(
              left: i * 36.0,
              child: Container(
                width: 48,
                height: 64,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.surfaceContainerLow,
                    width: 2,
                  ),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(9),
                  child: ColorFiltered(
                    colorFilter: greyscale
                        ? const ColorFilter.matrix([
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0.2126, 0.7152, 0.0722, 0, 0,
                            0,      0,      0,      1, 0,
                          ])
                        : const ColorFilter.mode(
                            Colors.transparent, BlendMode.multiply),
                    child: Image.network(
                      shown[i],
                      fit: BoxFit.cover,
                      errorBuilder: (_, _, _) =>
                          Container(color: AppColors.surfaceContainer),
                    ),
                  ),
                ),
              ),
            );
          }),
          if (extra > 0)
            Positioned(
              left: shown.length * 36.0,
              child: Container(
                width: 48,
                height: 64,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(
                    color: AppColors.surfaceContainerLow,
                    width: 2,
                  ),
                ),
                child: Center(
                  child: Text(
                    '+$extra',
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: AppColors.onSurfaceVariant,
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

// ─── Empty State ──────────────────────────────────────────────────────────────

class _EmptyState extends StatelessWidget {
  final String tab;
  const _EmptyState({required this.tab});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.receipt_long_outlined,
            size: 56, color: AppColors.outlineVariant),
        const SizedBox(height: 16),
        Text(
          'No $tab orders',
          style: GoogleFonts.newsreader(
            fontSize: 20,
            fontWeight: FontWeight.w400,
            color: AppColors.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
