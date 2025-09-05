import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class MultiValueListenableBuilder extends StatelessWidget {
  /// List of [ValueListenable]s to listen to.
  final List<ValueListenable> valueListenables;

  /// The builder function to be called when value of any of the [ValueListenable] changes.
  /// The order of values list will be same as [valueListenables] list.
  final Widget Function(
      BuildContext context, List<dynamic> values, Widget? child) builder;

  /// An optional child widget which will be avaliable as child parameter in [builder].
  final Widget? child;

  // The const constructor.
  const MultiValueListenableBuilder({
    super.key,
    required this.valueListenables,
    required this.builder,
    this.child,
  }) : assert(valueListenables.length != 0);

  @override
  Widget build(BuildContext context) {
    return ListenableBuilder(
      listenable: Listenable.merge(valueListenables),
      builder: (context, child) {
        final list = valueListenables.map((listenable) => listenable.value);
        return builder(context, List.unmodifiable(list), child);
      },
      child: child,
    );
  }
}
