import 'package:go_router/go_router.dart';

import '../screens/CreateScreen.dart';
import '../screens/DetailScreen.dart';
import '../screens/EditScreen.dart';
import '../screens/HomeScreen.dart';

final GoRouter router = GoRouter(
      initialLocation: '/',
      routes: <RouteBase>[
            GoRoute(
                  path: '/',
                  builder: (context, state) =>  HomeScreen(),
                  routes: [
                        GoRoute(
                              path: 'create',
                              builder: (context, state) => const CreateScreen(),
                        ),
                        GoRoute(
                              path: 'details/:id',
                              builder: (context, state) => DetailScreen(
                                    id: int.parse(state.pathParameters['id']!),
                              ),
                        ),
                        GoRoute(
                              path: 'edit/:id',
                              builder: (context, state) => EditScreen(
                                    id: int.parse(state.pathParameters['id']!),
                              ),
                        ),
                  ],
            ),
      ],
);
