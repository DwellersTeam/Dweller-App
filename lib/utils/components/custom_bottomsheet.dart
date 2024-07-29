import 'package:dweller/utils/colors/appcolor.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';





class TopModalBottomSheet extends ModalRoute<void> {
  final WidgetBuilder builder;

  TopModalBottomSheet({required this.builder});

  @override
  Duration get transitionDuration => const Duration(milliseconds: 300);

  @override
  bool get barrierDismissible => true;

  @override
  Color get barrierColor => Colors.black54;

  @override
  String get barrierLabel => 'Dismiss';

  @override
  bool get maintainState => true;

  @override
  Widget buildPage(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
  ) {
    return MediaQuery.removePadding(
      context: context,
      removeTop: true,
      child: Builder(
        builder: builder,
      ),
    );
  }

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(0.0, -1.0),
        end: Offset.zero,
      ).animate(animation),
      child: child,
    );
  }
  
  @override
  // TODO: implement opaque
  bool get opaque => throw UnimplementedError();
}


Future<void> showTopModalBottomSheet({
  required BuildContext context,
  required Widget child
  }) async{
  Navigator.of(context).push(
    TopModalBottomSheet(
      builder: (context) => child
      ),
    );
  }