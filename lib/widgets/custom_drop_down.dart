import 'package:flutter/material.dart';

class CustomDropdownWidget<T> extends StatefulWidget {
  final String label;
  final bool dark;
  final List<T> items;
  final void Function(T) onChanged;
  final T? initialValue;

  const CustomDropdownWidget({
    Key? key,
    required this.label,
    required this.items,
    required this.onChanged,
    this.dark = false,
    this.initialValue,
  }) : super(key: key);

  @override
  _CustomDropdownWidgetState<T> createState() =>
      _CustomDropdownWidgetState<T>();
}

class _CustomDropdownWidgetState<T> extends State<CustomDropdownWidget<T>> {
  late T selectedItem;

  @override
  void initState() {
    super.initState();
    selectedItem = widget.initialValue ?? widget.items.first;
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: Theme.of(context)
              .textTheme
              .bodyLarge!
              .copyWith(color: widget.dark ? Colors.black : Colors.white),
        ),
        Container(
          width: width,
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.3),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: DropdownButton<T>(
              underline: const SizedBox.shrink(),
              value: selectedItem,
              onChanged: (value) {
                setState(() {
                  selectedItem = value as T;
                });
                widget.onChanged(selectedItem);
              },
              selectedItemBuilder: (BuildContext c) {
                return widget.items.map<Widget>((item) {
                  return DropdownMenuItem(
                      value: item,
                      child: Text(
                        item.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .displayMedium!
                            .copyWith(
                            color:
                            widget.dark ? Colors.black : Colors.white),
                      ));
                }).toList();
              },
              items: widget.items.map((item) {
                return DropdownMenuItem<T>(
                  value: item,
                  child: Text(
                    item.toString(),
                    style: Theme.of(context)
                        .textTheme
                        .displayMedium!
                        .copyWith(color: Colors.black),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}