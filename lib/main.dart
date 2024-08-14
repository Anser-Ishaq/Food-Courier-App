import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:food_couriers/constants/routes/routes.dart';
import 'package:food_couriers/providers/auth_provider.dart';
import 'package:food_couriers/providers/map_provider.dart';
import 'package:food_couriers/providers/user_provider.dart';
import 'package:food_couriers/services/navigation_service.dart';
import 'package:food_couriers/utils.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:food_couriers/constants/colors/app_colors.dart';

void main() async {
  await dotenv.load(fileName: ".env");
  await setup();
  runApp(MyApp());
}

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupFirebase();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: AppColors.primary,
      systemNavigationBarIconBrightness: Brightness.light,
      systemNavigationBarDividerColor: AppColors.primary,
    ),
  );
  await registerServices();
}

class MyApp extends StatelessWidget {
  final GetIt _getIt = GetIt.instance;

  late NavigationService _navigationService;
  MyApp({super.key}) {
    _navigationService = _getIt<NavigationService>();
  }

  @override
  Widget build(BuildContext context) {
    const primarySwatch = MaterialColor(
            0xFFD61355,
            <int, Color>{
              50: Color(0xFFFDE6EE),
              100: Color(0xFFFBC0D3),
              200: Color(0xFFF78AAE),
              300: Color(0xFFF25589),
              400: Color(0xFFEE306F),
              500: Color(0xFFD61355),
              600: Color(0xFFCB114E),
              700: Color(0xFFA50E41),
              800: Color(0xFF800B34),
              900: Color(0xFF5A0727),
            },
          );
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => MapProvider()),
      ],
      child: MaterialApp(
        navigatorKey: _navigationService.navigatorKey,
        title: 'Food Couriers',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          primarySwatch: primarySwatch,
          useMaterial3: true,
        ),
        initialRoute: Routes.splash,
        routes: _navigationService.routes,
      ),
    );
  }
}
