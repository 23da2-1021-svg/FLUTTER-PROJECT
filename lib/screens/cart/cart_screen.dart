import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';
import '../../models/cart_item_model.dart';
import '../../providers/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cart = context.watch<CartProvider>();
    final items = cart.items;

    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SafeArea(
        child: Column(
          children: [
            _AppBar(itemCount: items.length),
            Expanded(
              child: items.isEmpty
                  ? const _EmptyCart()
                  : SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(24, 0, 24, 120),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(height: 28),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'My Cart',
                                style: GoogleFonts.newsreader(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurface,
                                  letterSpacing: -0.5,
                                ),
                              ),
                              Text(
                                '(${items.length} items)',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurfaceVariant,
                                  letterSpacing: 2.0,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          ...items.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 16),
                                child: _CartItemCard(
                                  item: item,
                                  onRemove: () => context
                                      .read<CartProvider>()
                                      .removeItem(item.product.id, item.selectedSize),
                                  onQtyChange: (delta) {
                                    final provider = context.read<CartProvider>();
                                    if (delta > 0) {
                                      provider.incrementQuantity(
                                          item.product.id, item.selectedSize);
                                    } else {
                                      provider.decrementQuantity(
                                          item.product.id, item.selectedSize);
                                    }
                                  },
                                ),
                              )),
                          const SizedBox(height: 32),
                          _OrderSummary(subtotal: cart.subtotal),
                        ],
                      ),
                    ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: items.isEmpty
          ? null
          : _CheckoutBar(total: cart.subtotal),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  final int itemCount;
  const _AppBar({required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: AppColors.creamWhite.withValues(alpha: 0.9),
      ),
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
          Stack(
            clipBehavior: Clip.none,
            children: [
              Icon(Icons.shopping_bag_outlined,
                  color: AppColors.primaryContainer, size: 24),
              if (itemCount > 0)
                Positioned(
                  top: -4,
                  right: -4,
                  child: Container(
                    width: 16,
                    height: 16,
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        '$itemCount',
                        style: GoogleFonts.inter(
                          fontSize: 9,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Cart Item Card ───────────────────────────────────────────────────────────

class _CartItemCard extends StatelessWidget {
  final CartItemModel item;
  final VoidCallback onRemove;
  final ValueChanged<int> onQtyChange;

  const _CartItemCard({
    required this.item,
    required this.onRemove,
    required this.onQtyChange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLowest,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Thumbnail
          ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: SizedBox(
              width: 110,
              height: 148,
              child: Image.network(
                item.product.imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) =>
                    Container(color: AppColors.surfaceContainer),
              ),
            ),
          ),
          const SizedBox(width: 16),

          // Details
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name + close
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        item.product.name,
                        style: GoogleFonts.newsreader(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: AppColors.onSurface,
                          height: 1.2,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onRemove,
                      child: Icon(Icons.close,
                          size: 20, color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                _DetailRow(label: 'Size', value: item.selectedSize),
                const SizedBox(height: 16),

                // Price + qty
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${item.totalPrice.toStringAsFixed(2)}',
                      style: GoogleFonts.inter(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainer,
                        borderRadius: BorderRadius.circular(999),
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () => onQtyChange(-1),
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: Icon(Icons.remove,
                                  size: 14, color: AppColors.onSurface),
                            ),
                          ),
                          SizedBox(
                            width: 20,
                            child: Text(
                              '${item.quantity}',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.inter(
                                fontSize: 13,
                                fontWeight: FontWeight.w600,
                                color: AppColors.onSurface,
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => onQtyChange(1),
                            child: SizedBox(
                              width: 28,
                              height: 28,
                              child: Icon(Icons.add,
                                  size: 14, color: AppColors.onSurface),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  final String label;
  final String value;
  const _DetailRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: GoogleFonts.inter(fontSize: 12, letterSpacing: 1.2),
        children: [
          TextSpan(
            text: '$label: ',
            style: TextStyle(
                color: AppColors.onSurfaceVariant,
                fontWeight: FontWeight.w500),
          ),
          TextSpan(
            text: value,
            style: TextStyle(
                color: AppColors.onSurface, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

// ─── Order Summary ────────────────────────────────────────────────────────────

class _OrderSummary extends StatelessWidget {
  final double subtotal;
  const _OrderSummary({required this.subtotal});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: AppColors.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Summary',
            style: GoogleFonts.newsreader(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
          Divider(color: AppColors.outlineVariant, height: 24),
          _SummaryRow(
              label: 'Subtotal',
              value: '\$${subtotal.toStringAsFixed(2)}'),
          const SizedBox(height: 14),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'DELIVERY',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurfaceVariant,
                  letterSpacing: 2.0,
                ),
              ),
              Text(
                'COMPLIMENTARY',
                style: GoogleFonts.inter(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: AppColors.secondary,
                  letterSpacing: 1.5,
                ),
              ),
            ],
          ),
          Divider(
            color: AppColors.outlineVariant.withValues(alpha: 0.3),
            height: 28,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Total',
                style: GoogleFonts.newsreader(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                ),
              ),
              Text(
                '\$${subtotal.toStringAsFixed(2)}',
                style: GoogleFonts.newsreader(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.onSurface,
                  letterSpacing: -0.5,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  final String label;
  final String value;
  const _SummaryRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 2.0,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}

// ─── Checkout Bar ─────────────────────────────────────────────────────────────

class _CheckoutBar extends StatelessWidget {
  final double total;
  const _CheckoutBar({required this.total});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.creamWhite,
        border: Border(
          top: BorderSide(
              color: AppColors.outlineVariant.withValues(alpha: 0.3)),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          height: 56,
          child: ElevatedButton(
            onPressed: () => context.push(AppRouter.checkout),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.secondary,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 0,
            ),
            child: Text(
              'PROCEED TO CHECKOUT',
              style: GoogleFonts.inter(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Colors.white,
                letterSpacing: 2.0,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ─── Empty Cart ───────────────────────────────────────────────────────────────

class _EmptyCart extends StatelessWidget {
  const _EmptyCart();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.shopping_bag_outlined,
              size: 64, color: AppColors.outlineVariant),
          const SizedBox(height: 20),
          Text(
            'Your cart is empty',
            style: GoogleFonts.newsreader(
              fontSize: 22,
              fontWeight: FontWeight.w400,
              color: AppColors.onSurfaceVariant,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Discover pieces made for you.',
            style: GoogleFonts.inter(
              fontSize: 13,
              color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            ),
          ),
        ],
      ),
    );
  }
}
