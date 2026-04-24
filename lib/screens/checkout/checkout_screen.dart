import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/constants/app_colors.dart';

enum _PaymentMethod { cod, card }

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  _PaymentMethod _payment = _PaymentMethod.cod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.creamWhite,
      body: SafeArea(
        child: Column(
          children: [
            // App bar
            _AppBar(),

            // Scrollable body
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(24, 24, 24, 120),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ── Delivery Details ────────────────────────────────
                    _SectionTitle('Delivery Details'),
                    const SizedBox(height: 12),
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF0EAE2),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: _DeliveryField(
                                  label: 'Full Name',
                                  value: 'Julianne Sterling',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _DeliveryField(
                                  label: 'Phone Number',
                                  value: '+1 (555) 012-3456',
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),
                          _DeliveryField(
                            label: 'Shipping Address',
                            value: '824 Kensington Gardens, Apt 4C',
                          ),
                          const SizedBox(height: 20),
                          Row(
                            children: [
                              Expanded(
                                child: _DeliveryField(
                                  label: 'City',
                                  value: 'London',
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: _DeliveryField(
                                  label: 'Postal Code',
                                  value: 'W8 4QP',
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),

                    // ── Payment Method ──────────────────────────────────
                    _SectionTitle('Payment Method'),
                    const SizedBox(height: 12),
                    _PaymentOption(
                      icon: Icons.payments_outlined,
                      title: 'Cash on Delivery',
                      subtitle: 'Pay when your order arrives',
                      selected: _payment == _PaymentMethod.cod,
                      onTap: () =>
                          setState(() => _payment = _PaymentMethod.cod),
                    ),
                    const SizedBox(height: 10),
                    _PaymentOption(
                      icon: Icons.credit_card_outlined,
                      title: 'Credit / Debit Card',
                      subtitle: 'Pay securely online',
                      selected: _payment == _PaymentMethod.card,
                      onTap: () =>
                          setState(() => _payment = _PaymentMethod.card),
                    ),
                    const SizedBox(height: 32),

                    // ── Order Summary ───────────────────────────────────
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: AppColors.surfaceContainerHigh,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Order Summary',
                            style: GoogleFonts.newsreader(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                              fontStyle: FontStyle.italic,
                              color: AppColors.onSurface,
                            ),
                          ),
                          const SizedBox(height: 16),

                          // Order item
                          Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: SizedBox(
                                  width: 64,
                                  height: 64,
                                  child: Image.network(
                                    'https://lh3.googleusercontent.com/aida-public/AB6AXuAYGfKEOwAAtKvNcYrMBclLAT0H57pa9AVr3uOzpJPnvDt95R3A3SKixoVNWJskisiQ-BSxque5PXr6EbuZXGmLzSNcsdy-sKwLbMZc4H3tA5-9M2LWaU4B610RlutWWxqL0Fc4x_Zr808-kZpQlcR6zJTN_U_kP5BC_z5ZXBJqI3u93HhcfoRGWhrhoqBSYPxdzsT-jF_sZNrv1RexDsgOqwrBJ3GWY39j6O6fkqhRhsmJoSTnpK71obcaDtQHpNF5edMWsaOKD8nH',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, _, _) => Container(
                                        color: AppColors.surfaceContainer),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 14),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Atelier Low-Top Sneaker',
                                      style: GoogleFonts.inter(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.onSurface,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'Size: 42 • Color: Sand',
                                      style: GoogleFonts.inter(
                                        fontSize: 11,
                                        color: AppColors.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Text(
                                '\$320.00',
                                style: GoogleFonts.newsreader(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.onSurface,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.outlineVariant
                                .withValues(alpha: 0.3),
                            height: 28,
                          ),

                          // Cost rows
                          _CostRow(label: 'Subtotal', value: '\$320.00'),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'SHIPPING',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  color: AppColors.onSurfaceVariant,
                                  letterSpacing: 1.5,
                                ),
                              ),
                              Text(
                                'COMPLIMENTARY',
                                style: GoogleFonts.inter(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.secondary,
                                  letterSpacing: 1.0,
                                ),
                              ),
                            ],
                          ),
                          Divider(
                            color: AppColors.outlineVariant
                                .withValues(alpha: 0.15),
                            height: 24,
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
                                '\$320.00',
                                style: GoogleFonts.newsreader(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w700,
                                  color: AppColors.primary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),

      // Place Order bottom bar
      bottomNavigationBar: _PlaceOrderBar(),
    );
  }
}

// ─── App Bar ──────────────────────────────────────────────────────────────────

class _AppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        color: AppColors.creamWhite.withValues(alpha: 0.9),
      ),
      child: Row(
        children: [
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: AppColors.primaryContainer,
            onPressed: () => Navigator.maybePop(context),
          ),
          Expanded(
            child: Center(
              child: Text(
                'Checkout',
                style: GoogleFonts.newsreader(
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                  fontStyle: FontStyle.italic,
                  color: AppColors.primaryContainer,
                ),
              ),
            ),
          ),
          const SizedBox(width: 48),
        ],
      ),
    );
  }
}

// ─── Section Title ────────────────────────────────────────────────────────────

class _SectionTitle extends StatelessWidget {
  final String text;
  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: GoogleFonts.newsreader(
        fontSize: 20,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.italic,
        color: AppColors.onSurfaceVariant,
      ),
    );
  }
}

// ─── Delivery Field ───────────────────────────────────────────────────────────

class _DeliveryField extends StatelessWidget {
  final String label;
  final String value;
  const _DeliveryField({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 2.0,
          ),
        ),
        const SizedBox(height: 6),
        Padding(
          padding: const EdgeInsets.only(bottom: 8),
          child: Text(
            value,
            style: GoogleFonts.inter(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.onSurface,
            ),
          ),
        ),
        Divider(
          color: AppColors.outlineVariant.withValues(alpha: 0.25),
          height: 1,
        ),
      ],
    );
  }
}

// ─── Payment Option ───────────────────────────────────────────────────────────

class _PaymentOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool selected;
  final VoidCallback onTap;

  const _PaymentOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedOpacity(
        duration: const Duration(milliseconds: 180),
        opacity: selected ? 1.0 : 0.55,
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: AppColors.surfaceContainerLow,
            borderRadius: BorderRadius.circular(12),
            border: selected
                ? Border.all(
                    color: AppColors.primary.withValues(alpha: 0.2))
                : null,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.surfaceContainerHigh,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  icon,
                  size: 20,
                  color: selected
                      ? AppColors.primary
                      : AppColors.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.inter(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      subtitle,
                      style: GoogleFonts.inter(
                        fontSize: 11,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 20,
                height: 20,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(
                    color: selected
                        ? AppColors.primary
                        : AppColors.outlineVariant,
                    width: 2,
                  ),
                ),
                child: selected
                    ? Center(
                        child: Container(
                          width: 10,
                          height: 10,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: AppColors.primary,
                          ),
                        ),
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ─── Cost Row ─────────────────────────────────────────────────────────────────

class _CostRow extends StatelessWidget {
  final String label;
  final String value;
  const _CostRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 11,
            color: AppColors.onSurfaceVariant,
            letterSpacing: 1.5,
          ),
        ),
        Text(
          value,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
          ),
        ),
      ],
    );
  }
}

// ─── Place Order Bar ──────────────────────────────────────────────────────────

class _PlaceOrderBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
      decoration: BoxDecoration(
        color: AppColors.surface.withValues(alpha: 0.9),
        border: Border(
          top: BorderSide(
              color: AppColors.surfaceContainerHigh),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.gold,
                  foregroundColor: Colors.white,
                  elevation: 4,
                  shadowColor: AppColors.gold.withValues(alpha: 0.3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: Text(
                  'PLACE ORDER',
                  style: GoogleFonts.inter(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    letterSpacing: 2.5,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'SECURE SSL ENCRYPTED CHECKOUT BY LOOM & CO',
              textAlign: TextAlign.center,
              style: GoogleFonts.inter(
                fontSize: 9,
                color: AppColors.onSurfaceVariant,
                letterSpacing: 1.2,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
