import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import '../../core/constants/app_colors.dart';
import '../../core/router/app_router.dart';
import '../../data/mock/mock_data.dart';
import '../../models/product_model.dart';
import '../../providers/wishlist_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _searchController = TextEditingController();
  int _selectedCategory   = 0;

  static const _categories = ['All', 'Women', 'Men', 'Kids', 'Accessories', 'Sale'];

  List<ProductModel> get _filteredProducts {
    final cat = _categories[_selectedCategory];
    return MockData.getByCategory(cat);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 100),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),
                    _GreetingSection(),
                    const SizedBox(height: 20),
                    _SearchBar(controller: _searchController),
                    const SizedBox(height: 24),
                    _HeroBanner(),
                    const SizedBox(height: 28),
                    _CategorySection(
                      categories: _categories,
                      selected: _selectedCategory,
                      onSelect: (i) => setState(() => _selectedCategory = i),
                    ),
                    const SizedBox(height: 28),
                    _NewArrivalsSection(products: _filteredProducts),
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
      decoration: BoxDecoration(
        color: AppColors.creamWhite.withValues(alpha: 0.9),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Icon(Icons.menu, color: AppColors.primary, size: 24),
              const SizedBox(width: 8),
              Text(
                'Loom & Co',
                style: GoogleFonts.newsreader(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.onSurface,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          Row(
            children: [
              Icon(Icons.notifications_none_outlined,
                  color: AppColors.primary, size: 24),
              const SizedBox(width: 16),
              Icon(Icons.shopping_bag_outlined,
                  color: AppColors.primary, size: 24),
            ],
          ),
        ],
      ),
    );
  }
}

// ─── Greeting ─────────────────────────────────────────────────────────────────

class _GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'WELCOME BACK',
          style: GoogleFonts.inter(
            fontSize: 10,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.7),
            letterSpacing: 3.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          'Bonjour, Camille',
          style: GoogleFonts.newsreader(
            fontSize: 30,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
            letterSpacing: -0.5,
          ),
        ),
      ],
    );
  }
}

// ─── Search Bar ───────────────────────────────────────────────────────────────

class _SearchBar extends StatelessWidget {
  final TextEditingController controller;
  const _SearchBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: GoogleFonts.inter(fontSize: 14, color: AppColors.onSurface),
      decoration: InputDecoration(
        hintText: 'Search the collection...',
        hintStyle: GoogleFonts.inter(
          fontSize: 14,
          color: AppColors.outline,
        ),
        prefixIcon: Icon(Icons.search, color: AppColors.outlineVariant, size: 22),
        filled: true,
        fillColor: AppColors.surfaceContainer,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
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

// ─── Hero Banner ──────────────────────────────────────────────────────────────

class _HeroBanner extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(16),
      child: SizedBox(
        height: 180,
        child: Stack(
          fit: StackFit.expand,
          children: [
            Image.network(
              'https://lh3.googleusercontent.com/aida-public/AB6AXuAJocv7ESc3MkVOacpGQBVtms7yADmXS8rrh7B6QFpDMm6g9ybPxnrxAW2kOCus2AOBhrpswQ8a9ac5MYTZK75dHoYDPFFLbHzjsy82qHeQ6vP3UyCYC9OgiAUPsW23EfColfzxOERYK4aDRcS9jKWDYncwBoCoMQdCKJ4FsM_ovbdJAL5dOPGcQNUGvUell5d7DLod_UarHP_AhrcRHGOtNUrpZRTbFtfMwUFLBRc0NwMnEcTXXrnO368oPYVsZOLkJqvZboI2Hdv0',
              fit: BoxFit.cover,
              errorBuilder: (_, _, _) =>
                  Container(color: AppColors.primaryContainer),
            ),
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.primary.withValues(alpha: 0.5),
                    Colors.transparent,
                  ],
                ),
              ),
            ),
            Positioned(
              left: 28,
              top: 0,
              bottom: 0,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summer Atelier\nCollection',
                    style: GoogleFonts.newsreader(
                      fontSize: 22,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                      height: 1.25,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'SHOP THE EDIT',
                    style: GoogleFonts.inter(
                      fontSize: 10,
                      color: Colors.white.withValues(alpha: 0.9),
                      letterSpacing: 2.5,
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

// ─── Category Chips ───────────────────────────────────────────────────────────

class _CategorySection extends StatelessWidget {
  final List<String> categories;
  final int selected;
  final ValueChanged<int> onSelect;

  const _CategorySection({
    required this.categories,
    required this.selected,
    required this.onSelect,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Categories',
          style: GoogleFonts.newsreader(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            fontStyle: FontStyle.italic,
            color: AppColors.onSurface,
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 38,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: categories.length,
            separatorBuilder: (_, _) => const SizedBox(width: 10),
            itemBuilder: (_, i) {
              final active = i == selected;
              return GestureDetector(
                onTap: () => onSelect(i),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20, vertical: 8),
                  decoration: BoxDecoration(
                    color: active
                        ? AppColors.primary
                        : AppColors.surfaceContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    categories[i],
                    style: GoogleFonts.inter(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.5,
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
      ],
    );
  }
}

// ─── New Arrivals Grid ────────────────────────────────────────────────────────

class _NewArrivalsSection extends StatelessWidget {
  final List<ProductModel> products;
  const _NewArrivalsSection({required this.products});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'New Arrivals',
              style: GoogleFonts.newsreader(
                fontSize: 24,
                fontWeight: FontWeight.w500,
                color: AppColors.onSurface,
              ),
            ),
            Text(
              'SEE ALL',
              style: GoogleFonts.inter(
                fontSize: 10,
                fontWeight: FontWeight.w600,
                color: AppColors.secondary,
                letterSpacing: 2.0,
              ),
            ),
          ],
        ),
        Divider(
          color: AppColors.outlineVariant.withValues(alpha: 0.2),
          thickness: 1,
          height: 20,
        ),
        const SizedBox(height: 8),
        GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 14,
            mainAxisSpacing: 20,
            childAspectRatio: 0.62,
          ),
          itemCount: products.length,
          itemBuilder: (ctx, i) => GestureDetector(
            onTap: () => ctx.push(AppRouter.productDetail, extra: products[i]),
            child: _ProductCard(product: products[i]),
          ),
        ),
      ],
    );
  }
}

class _ProductCard extends StatelessWidget {
  final ProductModel product;
  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final wishlisted =
        context.watch<WishlistProvider>().isWishlisted(product.id);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Image
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
                      Container(color: AppColors.surfaceContainer),
                ),
                Positioned(
                  top: 10,
                  right: 10,
                  child: GestureDetector(
                    onTap: () => context
                        .read<WishlistProvider>()
                        .toggle(product),
                    child: Container(
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.85),
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        wishlisted
                            ? Icons.favorite
                            : Icons.favorite_border,
                        size: 16,
                        color: wishlisted
                            ? AppColors.error
                            : AppColors.primary,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Category label
        Text(
          product.category.toUpperCase(),
          style: GoogleFonts.inter(
            fontSize: 9,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurfaceVariant.withValues(alpha: 0.6),
            letterSpacing: 1.8,
          ),
        ),
        const SizedBox(height: 3),
        // Product name
        Text(
          product.name,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.onSurface,
            height: 1.3,
          ),
        ),
        const SizedBox(height: 3),
        // Price
        Text(
          '\$${product.price.toStringAsFixed(2)}',
          style: GoogleFonts.inter(
            fontSize: 13,
            fontWeight: FontWeight.w600,
            color: AppColors.secondary,
          ),
        ),
      ],
    );
  }
}

