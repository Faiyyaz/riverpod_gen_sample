import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stack_trace/stack_trace.dart' as stack_trace;

import 'features/home/view/home_screen.dart';
import 'features/single/view/single_screen.dart';

Future<void> main() async {
  // wrap the entire app with a ProviderScope so that widgets
  // will be able to read providers
  WidgetsFlutterBinding.ensureInitialized();
  FlutterError.demangleStackTrace = (StackTrace stack) {
    if (stack is stack_trace.Trace) return stack.vmTrace;
    if (stack is stack_trace.Chain) return stack.toTrace().vmTrace;
    return stack;
  };

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
    ),
  );

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) async {
    runApp(
      const ProviderScope(
        child: MyApp(),
      ),
    );
  });
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Placeholder',
      builder: (context, widget) {
        ///Overriding textScaleFactor so that it cannot be change from settings
        ///& used .sp so that the font size will be auto adjustable by screen size
        final MediaQueryData data = MediaQuery.of(context);

        return MediaQuery(
          data: data.copyWith(textScaleFactor: 1.0),
          child: widget!,
        );
      },
      theme: ThemeData.light(),
      home: const HomeScreen(),
      onGenerateRoute: _getRoute,
    );
  }

  /// This method is used for named navigation
  Route? _getRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/single':
        return _buildRoute(
          settings,
          SingleScreen(
            id: settings.arguments as int,
          ),
        );
      default:
        return null;
    }
  }

  /// This function is where the navigation happens
  MaterialPageRoute _buildRoute(RouteSettings settings, Widget widget) {
    return MaterialPageRoute(
      settings: settings,
      builder: (ctx) => widget,
    );
  }
}
