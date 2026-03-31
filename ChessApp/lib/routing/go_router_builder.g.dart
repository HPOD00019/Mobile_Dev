// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'go_router_builder.dart';

// **************************************************************************
// GoRouterGenerator
// **************************************************************************

List<RouteBase> get $appRoutes => [$botSelectScreenRoute, $gameScreenRoute];

RouteBase get $botSelectScreenRoute => GoRouteData.$route(
  path: '/bots',
  factory: $BotSelectScreenRoute._fromState,
);

mixin $BotSelectScreenRoute on GoRouteData {
  static BotSelectScreenRoute _fromState(GoRouterState state) =>
      BotSelectScreenRoute();

  @override
  String get location => GoRouteData.$location('/bots');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}

RouteBase get $gameScreenRoute => GoRouteData.$route(
  path: '/game/:sessionId',
  factory: $GameScreenRoute._fromState,
);

mixin $GameScreenRoute on GoRouteData {
  static GameScreenRoute _fromState(GoRouterState state) =>
      GameScreenRoute(sessionId: state.pathParameters['sessionId']!);

  GameScreenRoute get _self => this as GameScreenRoute;

  @override
  String get location =>
      GoRouteData.$location('/game/${Uri.encodeComponent(_self.sessionId)}');

  @override
  void go(BuildContext context) => context.go(location);

  @override
  Future<T?> push<T>(BuildContext context) => context.push<T>(location);

  @override
  void pushReplacement(BuildContext context) =>
      context.pushReplacement(location);

  @override
  void replace(BuildContext context) => context.replace(location);
}
