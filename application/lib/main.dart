import 'dart:io';

import 'package:application/presentation/resources/asstes_manager.dart';
import 'package:application/presentation/resources/color_manager.dart';
import 'package:application/presentation/screens/add_patient/add_patient.dart';
import 'package:application/presentation/screens/clinics/clinics.dart';
import 'package:application/presentation/screens/follow_up/follow_up.dart';
import 'package:application/presentation/screens/home/home.dart';
import 'package:application/presentation/screens/pharmacy/parmacy.dart';
import 'package:application/presentation/screens/screening/screening.dart';
import 'package:application/presentation/screens/settings/settings.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_acrylic/flutter_acrylic.dart' as flutter_acrylic;
import 'package:application/theme.dart';
import 'package:fluent_ui/fluent_ui.dart';

import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:system_theme/system_theme.dart';
import 'package:window_manager/window_manager.dart';

import 'presentation/resources/responsive/app_settings.dart';
import 'presentation/screens/clinics/add_clinic/add_clinic.dart';
import 'presentation/screens/labs/labs.dart';

const String appTitle = 'Bedaya Convey Management System';

/// Checks if the current environment is a desktop environment.
bool get isDesktop {
  if (kIsWeb) return false;
  return [
    TargetPlatform.windows,
    TargetPlatform.linux,
    TargetPlatform.macOS,
  ].contains(defaultTargetPlatform);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // For performance (UI smoothness) debug (Profile mode)
  // Note: there are various type of performance like
  PerformanceOverlay.allEnabled(
    checkerboardOffscreenLayers: true,
  );
  if (!kIsWeb &&
      [
        TargetPlatform.windows,
        TargetPlatform.android,
      ].contains(defaultTargetPlatform)) {
    SystemTheme.accentColor.load();
  }

  if (isDesktop) {
    await flutter_acrylic.Window.initialize();
    await flutter_acrylic.Window.hideWindowControls();
    await WindowManager.instance.ensureInitialized();
    windowManager.waitUntilReadyToShow().then((_) async {
      await windowManager.setTitleBarStyle(
        TitleBarStyle.hidden,
        windowButtonVisibility: false,
      );
      await windowManager.setSize(const Size(755, 545));
      await windowManager.setMinimumSize(const Size(350, 600));
      await windowManager.center();
      await windowManager.show();
      await windowManager.setPreventClose(true);
      await windowManager.setSkipTaskbar(false);
    });
  }
  runApp(const App());
}

class App extends StatelessWidget {
  const App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => AppTheme(),
      builder: (context, state) {
        final appTheme = context.watch<AppTheme>();
        return FluentApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationParser: router.routeInformationParser,
          routerDelegate: router.routerDelegate,
          themeMode: appTheme.mode,
          theme: FluentThemeData(
            scaffoldBackgroundColor: ColorManager.secondaryDark,
            // menuColor: ColorManager.secondary,
            accentColor: appTheme.color,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          darkTheme: FluentThemeData(
            brightness: Brightness.dark,
            accentColor: appTheme.color,
            scaffoldBackgroundColor: ColorManager.blueDark.withAlpha(200),
            navigationPaneTheme: const NavigationPaneThemeData(
              backgroundColor: ColorManager.blueDark,
            ),
            // menuColor: ColorManager.secondary,
            visualDensity: VisualDensity.standard,
            focusTheme: FocusThemeData(
              glowFactor: is10footScreen() ? 2.0 : 0.0,
            ),
          ),
          color: appTheme.color,
          // color: Colors.red,
          builder: (context, child) {
            return Directionality(
              textDirection: appTheme.textDirection,
              child: NavigationPaneTheme(
                data: NavigationPaneThemeData(
                  backgroundColor: appTheme.windowEffect !=
                          flutter_acrylic.WindowEffect.disabled
                      ? Colors.transparent
                      : null,
                ),
                child: child!,
              ),
            );
          },
        );
      },
    );
  }
}

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
    required this.child,
    required this.shellContext,
    required this.state,
  });
  final Widget child;
  final BuildContext? shellContext;
  final GoRouterState state;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> with WindowListener {
  bool smallScreenWidth = false;
  bool isMobile = false;
  final viewKey = GlobalKey(debugLabel: 'Navigation View Key');
  final searchKey = GlobalKey(debugLabel: 'Search Bar Key');
  final searchFocusNode = FocusNode();
  final searchController = TextEditingController();
  int panIndex = 0;
  final List<NavigationPaneItem> originalItems = [
    PaneItem(
      key: const Key('/'),
      icon: const Icon(FluentIcons.home),
      title: const Text('Home'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/') router.pushNamed('home');
      },
    ),
    PaneItemExpander(
      key: const Key('/clinics'),
      icon: const Icon(FluentIcons.build),
      title: const Text('Clinics'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/clinics') router.pushNamed('clinics');
      },
      items: <PaneItem>[
        PaneItem(
          key: const Key('/clinics/add'),
          icon: const Icon(FluentIcons.add),
          body: const SizedBox.shrink(),
          title: const Text('Add clinic'),
          onTap: () {
            if (router.location != '/clinics/add') {
              router.pushNamed('add_clinic');
            }
          },
        ),
      ],
    ),
    PaneItem(
      key: const Key('/labs'),
      icon: const Icon(FluentIcons.library_add_to),
      title: const Text('Labs'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/labs') router.pushNamed('labs');
      },
    ),
    PaneItem(
      key: const Key('/pharmacy'),
      icon: const Icon(FluentIcons.cube_shape),
      title: const Text('Pharmacy'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/pharmacy') router.pushNamed('pharmacy');
      },
    ),
    PaneItem(
      key: const Key('/screening'),
      icon: const Icon(FluentIcons.scale_up),
      title: const Text('Screening'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/screening') router.pushNamed('screening');
      },
    ),
    PaneItem(
      key: const Key('/follow_up'),
      icon: const Icon(FluentIcons.contact_list),
      title: const Text('Follow-Up'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/follow_up') router.pushNamed('follow_up');
      },
    ),
    // PaneItemHeader(header: const Text('Inputs')),
  ];
  final List<NavigationPaneItem> footerItems = [
    PaneItemSeparator(),
    PaneItem(
      key: const Key('/add_patient'),
      icon: const Icon(FluentIcons.add),
      title: const Text('Add patient'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/add_patient') {
          router.pushNamed('add_patient');
        }
      },
    ),
    PaneItem(
      key: const Key('/settings'),
      icon: const Icon(FluentIcons.settings),
      title: const Text('Settings'),
      body: const SizedBox.shrink(),
      onTap: () {
        if (router.location != '/settings') {
          router.pushNamed('settings');
        }
      },
    ),
  ];
  int _calculateSelectedIndex(BuildContext context) {
    final location = router.location;
    int indexOriginal = originalItems
        .where((element) => element.key != null)
        .toList()
        .indexWhere((element) => element.key == Key(location));

    if (indexOriginal == -1) {
      int indexFooter = footerItems
          .where((element) => element.key != null)
          .toList()
          .indexWhere((element) => element.key == Key(location));
      if (indexFooter == -1) {
        return 0;
      }
      return originalItems
              .where((element) => element.key != null)
              .toList()
              .length +
          // 1 +
          indexFooter;
    } else {
      // return indexOriginal + 1;
      return indexOriginal;
    }
  }

  @override
  void initState() {
    super.initState();
    windowManager.addListener(this);
    isMobile = Platform.isAndroid && Platform.isIOS;
  }

  @override
  void dispose() {
    windowManager.removeListener(this);
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    smallScreenWidth = MediaQuery.of(context).size.width <= 400;
  }

  @override
  Widget build(BuildContext context) {
    // final localizations = FluentLocalizations.of(context);
    AppSettings.init(context);

    final appTheme = context.watch<AppTheme>();
    final theme = FluentTheme.of(context);
    if (widget.shellContext != null) {
      if (router.canPop() == false) {
        setState(() {});
      }
    }
    // works as a scaffold
    return NavigationView(
      key: viewKey,
      appBar: NavigationAppBar(
        height: 30,
        automaticallyImplyLeading: false,
        leading: smallScreenWidth
            ? null
            : () {
                final enabled = widget.shellContext != null && router.canPop();

                final onPressed = enabled
                    ? () {
                        if (router.canPop()) {
                          context.pop();
                          setState(() {});
                        }
                      }
                    : null;
                return NavigationPaneTheme(
                  data: NavigationPaneTheme.of(context).merge(
                    NavigationPaneThemeData(
                      unselectedIconColor: ButtonState.resolveWith((states) {
                        if (states.isDisabled) {
                          return ButtonThemeData.buttonColor(context, states);
                        }
                        return ButtonThemeData.uncheckedInputColor(
                          FluentTheme.of(context),
                          states,
                        ).basedOnLuminance();
                      }),
                    ),
                  ),
                  child: smallScreenWidth
                      ? const SizedBox.shrink()
                      : Builder(
                          builder: (context) => PaneItem(
                            icon: const Center(
                              child: Icon(FluentIcons.back, size: 10.0),
                            ),
                            title: const Text("Back"),
                            body: const SizedBox.shrink(),
                            enabled: enabled,
                          ).build(
                            context,
                            false,
                            onPressed,
                            displayMode: PaneDisplayMode.compact,
                          ),
                        ),
                );
              }(),
        title: () {
          if (kIsWeb) {
            return const Align(
              alignment: AlignmentDirectional.centerStart,
              child: Text(appTitle),
            );
          }
          return smallScreenWidth
              ? null
              : DragToMoveArea(
                  child: Align(
                    alignment: AlignmentDirectional.centerStart,
                    child: Text(
                      appTitle,
                      style:
                          FluentTheme.of(context).typography.caption?.copyWith(
                                fontSize: 11,
                              ),
                    ),
                  ),
                );
        }(),
        actions: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
          Padding(
            padding:
                EdgeInsetsDirectional.only(end: 8.0, top: isMobile ? 10 : 0),
            child: SizedBox(
              height: 25,
              child: ToggleSwitch(
                content: Text(
                  'Dark Mode',
                  style: FluentTheme.of(context).typography.caption?.copyWith(
                        fontSize: 11,
                      ),
                ),
                checked: FluentTheme.of(context).brightness.isDark,
                onChanged: (v) {
                  if (v) {
                    appTheme.mode = ThemeMode.dark;
                  } else {
                    appTheme.mode = ThemeMode.light;
                  }
                },
              ),
            ),
          ),
          if (!kIsWeb && !isMobile) const WindowButtons(),
        ]),
      ),
      paneBodyBuilder: (item, child) {
        final name =
            item?.key is ValueKey ? (item!.key as ValueKey).value : null;
        return FocusTraversalGroup(
          key: ValueKey('body$name'),
          child: widget.child,
        );
      },
      pane: NavigationPane(
        // size: const NavigationPaneSize(openMaxWidth: 260),

        items: originalItems,
        footerItems: footerItems,
        onChanged: (index) {
          panIndex = index;
          setState(() {});
        },
        selected: panIndex,
        // selected: _calculateSelectedIndex(context),
        header: SizedBox(
          height: kOneLineTileHeight,
          child: ShaderMask(
            shaderCallback: (rect) {
              final color = appTheme.color.defaultBrushFor(
                theme.brightness,
              );
              return LinearGradient(
                colors: [
                  color,
                  color,
                ],
              ).createShader(rect);
            },
            child: Row(
              children: [
                Image.asset(
                  AssetsManager.logo,
                  height: 80,
                ),
                Text(
                  "Bedaya",
                  style: FluentTheme.of(context)
                      .typography
                      .title
                      ?.copyWith(fontSize: 18),
                ),
              ],
            ),
          ),
        ),
        displayMode: appTheme.displayMode,
        // displayMode: PaneDisplayMode.compact,
        indicator: () {
          switch (appTheme.indicator) {
            case NavigationIndicators.end:
              return const EndNavigationIndicator();
            case NavigationIndicators.sticky:
              return const StickyNavigationIndicator();
          }
        }(),
        autoSuggestBox: AutoSuggestBox(
          items: originalItems.whereType<PaneItem>().map((item) {
            assert(item.title is Text);
            final text = (item.title as Text).data!;
            return AutoSuggestBoxItem(
                value: text,
                label: text,
                onSelected: () {
                  // TODO: Dirty code
                  // Re-calculate the index here
                  // panIndex = 1;
                  // changePanIndex();
                  switch ((item.title as Text).data) {
                    case 'Home':
                      setState(() {
                        panIndex = 0;
                        item.onTap!.call();
                      });
                      break;
                    case 'Clinics':
                      setState(() {
                        panIndex = 1;
                        item.onTap!.call();
                      });
                      break;
                    case 'Add clinic':
                      setState(() {
                        panIndex = 2;
                        item.onTap!.call();
                      });
                      break;
                    case 'Labs':
                      setState(() {
                        panIndex = 3;
                        // item.onTap!.call();
                      });
                      break;
                    case 'Pharmacy':
                      setState(() {
                        panIndex = 4;
                        item.onTap!.call();
                      });
                      break;
                    case 'Screening':
                      setState(() {
                        panIndex = 5;
                        item.onTap!.call();
                      });
                      break;
                    case 'Follow-Up':
                      setState(() {
                        panIndex = 6;
                        item.onTap!.call();
                      });
                      break;
                    default:
                  }
                  searchController.clear();
                });
          }).toList(),
          trailingIcon: IconButton(
            onPressed: () {},
            icon: const Icon(FluentIcons.search),
          ),
          placeholder: "Search",
        ),
      ),
    );
  }

  @override
  void onWindowClose() async {
    // super.onWindowClose();
    // bool closeWindowPrevented = await windowManager.isPreventClose();
    windowManager.isPreventClose().then((value) {
      if (value) {
        showDialog(
          context: context,
          builder: (_) {
            return ContentDialog(
              title: const Text("Confirm close"),
              content: const Text("Are you sure you want to close this window"),
              actions: [
                FilledButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    Navigator.pop(context);
                    windowManager.destroy();
                  },
                ),
                Button(
                  child: const Text('No'),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          },
        );
      }
    });
  }
}

class WindowButtons extends StatelessWidget {
  const WindowButtons({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FluentThemeData theme = FluentTheme.of(context);

    return SizedBox(
      width: 138,
      height: 50,
      child: WindowCaption(
        brightness: theme.brightness,
        backgroundColor: Colors.transparent,
      ),
    );
  }
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(navigatorKey: _rootNavigatorKey, routes: [
  ShellRoute(
    navigatorKey: _shellNavigatorKey,
    builder: (context, state, child) {
      return MainLayout(
        shellContext: _shellNavigatorKey.currentContext,
        state: state,
        child: child,
      );
    },
    routes: [
      GoRoute(
        path: '/',
        name: 'home',
        builder: (context, state) => const Home(),
      ),
      GoRoute(
        path: '/clinics',
        name: 'clinics',
        builder: (context, state) => const ClinicsScreen(),
      ),
      GoRoute(
        path: '/clinics/add',
        name: 'add_clinic',
        builder: (context, state) => const AddClinicScreen(),
      ),
      GoRoute(
        path: '/settings',
        name: 'settings',
        builder: (context, state) => const Settings(),
      ),
      GoRoute(
        path: '/add_patient',
        name: 'add_patient',
        builder: (context, state) => const AddPatientScreen(),
      ),
      GoRoute(
        path: '/labs',
        name: 'labs',
        builder: (context, state) => const LabsScreen(),
      ),
      GoRoute(
        path: '/pharmacy',
        name: 'pharmacy',
        builder: (context, state) => const PharmacyScreen(),
      ),
      GoRoute(
        path: '/screening',
        name: 'screening',
        builder: (context, state) => const ScreeningScreen(),
      ),
      GoRoute(
        path: '/follow_up',
        name: 'follow_up',
        builder: (context, state) => const FollowUpScreen(),
      ),
    ],
  ),
]);
