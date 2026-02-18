import 'package:flutter/material.dart';

class ItemsList<T> extends StatelessWidget {
  const ItemsList(this.items, this.create, {super.key})
    : itemsCount = items.length;

  final int itemsCount;
  final List<T> items;
  final Widget Function(T) create;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: itemsCount,
      itemBuilder: (context, index) {
        // Begin: Item
        return create(items[index]);
      },
    );
  }
}
