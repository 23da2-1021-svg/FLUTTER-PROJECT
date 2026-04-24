import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';
import '../../data/mock/mock_data.dart';
import '../../models/product_model.dart';

class ProductListingScreen extends StatefulWidget {
  const ProductListingScreen({super.key});

  @override
  State<ProductListingScreen> createState() => _ProductListingScreenState();
}

class _ProductListingScreenState extends State<ProductListingScreen> {
  final Set<String> _wishlist    = {};
  int _activeFilter              = -1;

  static const _filters = ['Sort', 'Price', 'Size', 'Color'];

  void _toggleWishlist(String id) =>
      setState(() => _wishlist.contains(id) ? _wishlist.remove(id) : _wishlist.add(id));

  @override
  Widget build(BuildContext context) {
    final products = MockData.products;

    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            // ── Sticky App Bar ────────────────────────────────────────────
            SliverAppBar(
              pinned: true,
              elevation: 0,
              backgroundColor: AppColors.creamWhite.withValues(alpha: 0.9),
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
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
              ),
            ),

            // ── Header ────────────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding:
                    const EdgeInsets.fromLTRB(24, 28, 24, 0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'COLLECTION',
                          style: GoogleFonts.inter(
                            fontSize: 10,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurfaceVariant,
                            letterSpacing: 3.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'New Arrivals',
                          style: GoogleFonts.newsreader(
                            fontSize: 36,
                            fontWeight: FontWeight.w500,
                            color: AppColors.onSurface,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(Icons.tune,
                          color: AppColors.onSurfaceVariant, size: 20),
                    ),
                  ],
                ),
              ),
            ),

            // ── Filter Chips ──────────────────────────────────────────────
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(24, 20, 0, 28),
                child: SizedBox(
                  height: 38,
                  child: ListView.separated(
                    scrollDirection: Axis.horizontal,
                    itemCount: _filters.length,
                    separatorBuilder: (_, _) => const SizedBox(width: 8),
                    itemBuilder: (_, i) {
                      final active = i == _activeFilter;
                      return GestureDetector(
                        onTap: () => setState(() =>
                            _activeFilter = active ? -1 : i),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 180),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 8),
                          decoration: BoxDecoration(
                            color: active
                                ? AppColors.primaryContainer
                                : AppColors.surface,
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: active
                                  ? AppColors.primaryContainer
                                  : AppColors.outlineVariant
                                      .withValues(alpha: 0.3),
                            ),
                          ),
                          child: Text(
                            _filters[i],
                            style: GoogleFonts.inter(
                              fontSize: 12,
                              fontWeight: FontWeight.w500,
                              color: active
                                  ? Colors.white
                                  : AppColors.onSurfaceVariant,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),

            // ── Staggered Product Grid ────────────────────────────────────
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 40),
              sliver: SliverGrid(
                gridDelegate:
                    const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 14,
                  mainAxisSpacing: 0,
                  childAspectRatio: 0.52,
                ),
                delegate: SliverChildBuilderDelegate(
                  (ctx, i) => _ProductCard(
                    product: products[i],
                    wishlisted: _wishlist.contains(products[i].id),
                    onWishlist: () => _toggleWishlist(products[i].id),
                    staggered: i.isOdd,
                    onTap: () => ctx.push(AppRouter.productDetail, extra: products[i]),
                  ),
                  childCount: products.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ─── Product Card ─────────────────────────────────────────────────────────────

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  final bool wishlisted;
  final bool staggered;
  final VoidCallback onWishlist;
  final VoidCallback? onTap;

  const _ProductCard({
    required this.product,
    required this.wishlisted,
    required this.onWishlist,
    this.staggered = false,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.only(top: staggered ? 32 : 0, bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image container — 3:4 ratio
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    product.imageUrl,
                    fit: BoxFit.cover,
                    errorBuilder: (_, _, _) =>
                        Container(color: const Color(0xFFF0EAE2)),
                  ),
                  Positioned(
                    top: 10,
                    right: 10,
                    child: GestureDetector(
                      onTap: onWishlist,
                      child: Container(
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: AppColors.surface.withValues(alpha: 0.85),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          wishlisted
                              ? Icons.favorite
                              : Icons.favorite_border,
                          size: 16,
                          color: wishlisted
                              ? AppColors.primary
                              : AppColors.onSurface,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Name
          Text(
            product.name,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: const Color(0xFF1C1C1E),
              height: 1.3,
            ),
          ),
          const SizedBox(height: 3),
          // Category
          Text(
            product.category.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 10,
              color: AppColors.onSurfaceVariant,
              letterSpacing: 1.5,
            ),
          ),
          const SizedBox(height: 5),
          // Price
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: GoogleFonts.newsreader(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryContainer,
            ),
          ),
        ],
      ),
    ),
  );
  }
}

