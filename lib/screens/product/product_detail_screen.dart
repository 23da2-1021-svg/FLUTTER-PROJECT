import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../data/mock/mock_data.dart';
import '../../models/product_model.dart';
import '../../providers/cart_provider.dart';

class ProductDetailScreen extends StatefulWidget {
  final ProductModel product;

  const ProductDetailScreen({super.key, required this.product});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  int _selectedSize    = 1;
  int _selectedColor   = 0;
  int _quantity        = 1;
  bool _wishlisted     = false;
  bool _descExpanded   = false;
  bool _careExpanded   = false;
  bool _shippingExpanded = false;

  static const _colors = [
    Color(0xFF500524),
    Color(0xFF1B1B1D),
    Color(0xFFE5D3B3),
    Color(0xFF3B4D3C),
  ];

  @override
  Widget build(BuildContext context) {
    final product = widget.product;
    final sizes   = product.sizes;

    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: Stack(
        children: [
          // ── Scrollable content ────────────────────────────────────────
          CustomScrollView(
            slivers: [
              // Hero image
              SliverToBoxAdapter(
                child: AspectRatio(
                  aspectRatio: 3 / 4,
                  child: Stack(
                    fit: StackFit.expand,
                    children: [
                      Container(color: const Color(0xFFF0EAE2)),
                      Image.network(
                        product.imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, _, _) =>
                            Container(color: const Color(0xFFF0EAE2)),
                      ),
                      // Dot indicators
                      Positioned(
                        bottom: 20,
                        right: 20,
                        child: Row(
                          children: List.generate(3, (i) => Container(
                            margin: const EdgeInsets.only(left: 6),
                            width: 6,
                            height: 6,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: i == 0
                                  ? AppColors.primary
                                  : AppColors.onSurface
                                      .withValues(alpha: 0.2),
                            ),
                          )),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Detail canvas
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(24, 28, 24, 120),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Brand label
                      Text(
                        'LOOM & CO',
                        style: GoogleFonts.inter(
                          fontSize: 12,
                          fontWeight: FontWeight.w500,
                          color: AppColors.secondary,
                          letterSpacing: 3.2,
                        ),
                      ),
                      const SizedBox(height: 8),

                      // Product name
                      Text(
                        product.name,
                        style: GoogleFonts.newsreader(
                          fontSize: 30,
                          fontWeight: FontWeight.w300,
                          color: AppColors.onSurface,
                          letterSpacing: -0.5,
                          height: 1.2,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Price + rating row
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            '\$${product.price.toStringAsFixed(2)}',
                            style: GoogleFonts.newsreader(
                              fontSize: 24,
                              fontWeight: FontWeight.w700,
                              color: AppColors.primaryContainer,
                            ),
                          ),
                          Row(
                            children: [
                              ...List.generate(4, (_) => Icon(
                                    Icons.star_rounded,
                                    size: 16,
                                    color: AppColors.secondary,
                                  )),
                              Icon(Icons.star_half_rounded,
                                  size: 16, color: AppColors.secondary),
                              const SizedBox(width: 4),
                              Text(
                                '(128)',
                                style: GoogleFonts.inter(
                                  fontSize: 12,
                                  color: AppColors.onSurfaceVariant,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      const SizedBox(height: 28),

                      // Size selection
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'SELECT SIZE',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppColors.onSurfaceVariant,
                              letterSpacing: 2.0,
                            ),
                          ),
                          Text(
                            'SIZE GUIDE',
                            style: GoogleFonts.inter(
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                              color: AppColors.secondary,
                              letterSpacing: 1.5,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.secondary,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 14),
                      Wrap(
                        spacing: 10,
                        runSpacing: 10,
                        children: List.generate(sizes.length, (i) {
                          final selected = i == _selectedSize;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedSize = i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 180),
                              width: 48,
                              height: 48,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: selected
                                    ? AppColors.primaryContainer
                                    : Colors.transparent,
                                border: Border.all(
                                  color: selected
                                      ? AppColors.primaryContainer
                                      : AppColors.outlineVariant
                                          .withValues(alpha: 0.4),
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  sizes[i],
                                  style: GoogleFonts.inter(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w500,
                                    color: selected
                                        ? Colors.white
                                        : AppColors.onSurface,
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // Color selection
                      Text(
                        'COLOR',
                        style: GoogleFonts.inter(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: AppColors.onSurfaceVariant,
                          letterSpacing: 2.0,
                        ),
                      ),
                      const SizedBox(height: 14),
                      Row(
                        children: List.generate(_colors.length, (i) {
                          final selected = i == _selectedColor;
                          return GestureDetector(
                            onTap: () =>
                                setState(() => _selectedColor = i),
                            child: Container(
                              margin: const EdgeInsets.only(right: 14),
                              width: 32,
                              height: 32,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: _colors[i],
                                border: selected
                                    ? Border.all(
                                        color: _colors[i],
                                        width: 2,
                                      )
                                    : null,
                                boxShadow: selected
                                    ? [
                                        BoxShadow(
                                          color: _colors[i]
                                              .withValues(alpha: 0.4),
                                          blurRadius: 0,
                                          spreadRadius: 3,
                                        )
                                      ]
                                    : null,
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(height: 24),

                      // Quantity selector
                      Container(
                        decoration: BoxDecoration(
                          color: AppColors.surfaceContainer,
                          borderRadius: BorderRadius.circular(999),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 4, vertical: 4),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _QtyButton(
                              icon: Icons.remove,
                              onTap: () {
                                if (_quantity > 1) {
                                  setState(() => _quantity--);
                                }
                              },
                            ),
                            SizedBox(
                              width: 40,
                              child: Text(
                                '$_quantity',
                                textAlign: TextAlign.center,
                                style: GoogleFonts.inter(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ),
                            _QtyButton(
                              icon: Icons.add,
                              onTap: () =>
                                  setState(() => _quantity++),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 32),

                      // Accordion sections
                      Divider(
                          color: AppColors.surfaceContainerHigh
                              .withValues(alpha: 0.5)),
                      _AccordionItem(
                        title: 'Description',
                        expanded: _descExpanded,
                        onTap: () => setState(
                            () => _descExpanded = !_descExpanded),
                        content: product.description,
                      ),
                      _AccordionItem(
                        title: 'Composition & Care',
                        expanded: _careExpanded,
                        onTap: () => setState(
                            () => _careExpanded = !_careExpanded),
                        content:
                            '100% Pure Silk. Dry clean only. Do not tumble dry. Iron on low heat.',
                      ),
                      _AccordionItem(
                        title: 'Shipping & Returns',
                        expanded: _shippingExpanded,
                        onTap: () => setState(
                            () => _shippingExpanded = !_shippingExpanded),
                        content:
                            'Free standard shipping on orders over \$150. Returns accepted within 30 days of delivery.',
                      ),
                      const SizedBox(height: 40),

                      // Complete the Look
                      Text(
                        'Complete the Look',
                        style: GoogleFonts.newsreader(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          fontStyle: FontStyle.italic,
                          color: AppColors.onSurface,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 240,
                        child: ListView.separated(
                          scrollDirection: Axis.horizontal,
                          itemCount: MockData.products.length
                              .clamp(0, 4),
                          separatorBuilder: (_, _) =>
                              const SizedBox(width: 16),
                          itemBuilder: (_, i) =>
                              _UpsellCard(product: MockData.products[i]),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),

          // ── Floating App Bar ──────────────────────────────────────────
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                height: 64,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                decoration: BoxDecoration(
                  color: AppColors.surface.withValues(alpha: 0.85),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back),
                      color: AppColors.onSurface,
                      onPressed: () => Navigator.maybePop(context),
                    ),
                    Row(
                      children: [
                        IconButton(
                          icon: const Icon(Icons.share_outlined),
                          color: AppColors.onSurface,
                          onPressed: () {},
                        ),
                        IconButton(
                          icon: Icon(
                            _wishlisted
                                ? Icons.favorite
                                : Icons.favorite_border,
                            color: _wishlisted
                                ? AppColors.primary
                                : AppColors.onSurface,
                          ),
                          onPressed: () =>
                              setState(() => _wishlisted = !_wishlisted),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Sticky Add to Cart Bar ────────────────────────────────────
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
                decoration: BoxDecoration(
                  color: AppColors.creamWhite,
                  border: Border(
                    top: BorderSide(
                      color:
                          AppColors.outlineVariant.withValues(alpha: 0.3),
                    ),
                  ),
                ),
                child: SizedBox(
                  height: 52,
                  child: ElevatedButton(
                    onPressed: () {
                      context.read<CartProvider>().addItem(
                            product,
                            sizes[_selectedSize],
                          );
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${product.name} added to cart'),
                          duration: const Duration(seconds: 2),
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryContainer,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      elevation: 0,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.shopping_bag_outlined,
                            size: 18, color: Colors.white),
                        const SizedBox(width: 10),
                        Text(
                          'Add to Cart',
                          style: GoogleFonts.inter(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ],
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

// ─── Quantity Button ──────────────────────────────────────────────────────────

class _QtyButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onTap;
  const _QtyButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: SizedBox(
        width: 40,
        height: 40,
        child: Icon(icon, size: 18, color: AppColors.onSurface),
      ),
    );
  }
}

// ─── Accordion Item ───────────────────────────────────────────────────────────

class _AccordionItem extends StatelessWidget {
  final String title;
  final String content;
  final bool expanded;
  final VoidCallback onTap;

  const _AccordionItem({
    required this.title,
    required this.content,
    required this.expanded,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: GoogleFonts.newsreader(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                    color: AppColors.onSurface,
                  ),
                ),
                AnimatedRotation(
                  turns: expanded ? 0.5 : 0,
                  duration: const Duration(milliseconds: 200),
                  child: Icon(Icons.expand_more,
                      color: AppColors.onSurfaceVariant),
                ),
              ],
            ),
          ),
        ),
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Text(
              content,
              style: GoogleFonts.inter(
                fontSize: 13,
                color: AppColors.onSurfaceVariant,
                height: 1.6,
              ),
            ),
          ),
          crossFadeState: expanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
        Divider(
            color: AppColors.surfaceContainerHigh.withValues(alpha: 0.5)),
      ],
    );
  }
}

// ─── Upsell Card ─────────────────────────────────────────────────────────────

class _UpsellCard extends StatelessWidget {
  final ProductModel product;
  const _UpsellCard({required this.product});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.network(
                product.imageUrl,
                fit: BoxFit.cover,
                width: 150,
                errorBuilder: (_, _, _) =>
                    Container(color: AppColors.surfaceContainerLow),
              ),
            ),
          ),
          const SizedBox(height: 8),
          Text(
            product.category.toUpperCase(),
            style: GoogleFonts.inter(
              fontSize: 9,
              letterSpacing: 1.8,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            product.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          Text(
            '\$${product.price.toStringAsFixed(0)}',
            style: GoogleFonts.inter(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: AppColors.primaryContainer,
            ),
          ),
        ],
      ),
    );
  }
}
