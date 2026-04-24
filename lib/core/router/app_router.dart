import 'package:go_router/go_router.dart';
import '../../screens/splash/splash_screen.dart';
import '../../screens/auth/login_screen.dart';
import '../../screens/auth/register_screen.dart';
import '../../screens/main_scaffold/main_scaffold.dart';
import '../../screens/product/product_detail_screen.dart';
import '../../screens/checkout/checkout_screen.dart';
import '../../models/product_model.dart';

class AppRouter {
  AppRouter._();

  static const String splash        = '/';
  static const String login         = '/login';
  static const String register      = '/register';
  static const String main          = '/main';
  static const String productDetail = '/product-detail';
  static const String checkout      = '/checkout';

  static final GoRouter router = GoRouter(
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: register,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: main,
        builder: (context, state) => const MainScaffold(),
      ),
      GoRoute(
        path: productDetail,
        redirect: (context, state) =>
            state.extra == null ? AppRouter.main : null,
        builder: (context, state) {
          final product = state.extra as ProductModel;
          return ProductDetailScreen(product: product);
        },
      ),
      GoRoute(
        path: checkout,
        builder: (context, state) => const CheckoutScreen(),
      ),
    ],
  );
}
