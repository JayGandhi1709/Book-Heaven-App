// lib/editable_chip_field.dart

import 'package:flutter/material.dart';
import 'dart:async';

class EditableChipField extends StatefulWidget {
  const EditableChipField({
    Key? key,
    required this.list,
    required this.decoration,
  }) : super(key: key);

  final List<String> list;
  final InputDecoration decoration;

  @override
  _EditableChipFieldState createState() => _EditableChipFieldState();
}

class _EditableChipFieldState extends State<EditableChipField> {
  final FocusNode _chipFocusNode = FocusNode();
  List<String> _selectedToppings = [];
  List<String> _suggestions = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ChipsInput<String>(
            values: _selectedToppings,
            decoration: widget.decoration,
            strutStyle: const StrutStyle(fontSize: 15),
            onChanged: _onChanged,
            onSubmitted: _onSubmitted,
            chipBuilder: _chipBuilder,
            onTextChanged: _onSearchChanged,
          ),
        ),
        if (_suggestions.isNotEmpty)
          SizedBox(
            height: 600,
            child: ListView.builder(
              itemCount: _suggestions.length,
              itemBuilder: (BuildContext context, int index) {
                return ToppingSuggestion(
                  _suggestions[index],
                  onTap: _selectSuggestion,
                );
              },
            ),
          ),
      ],
    );
  }

  Future<void> _onSearchChanged(String value) async {
    final List<String> results = await _suggestionCallback(value);
    setState(() {
      _suggestions = results
          .where((String topping) => !_selectedToppings.contains(topping))
          .toList();
    });
  }

  Widget _chipBuilder(BuildContext context, String item) {
    return ToppingInputChip(
      item: item,
      onDeleted: () => _onChipDeleted(item),
      onSelected: () => _onChipTapped,
    );
  }

  void _selectSuggestion(String topping) {
    setState(() {
      _selectedToppings.add(topping);
      _suggestions = <String>[];
    });
  }

  void _onChipTapped(String item) {}

  void _onChipDeleted(String item) {
    print("come here");
    setState(() {
      _selectedToppings.remove(item);
      _suggestions = <String>[];
    });
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _selectedToppings.add(text.trim());
      });
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _selectedToppings = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _selectedToppings = data;
    });
  }

  Future<List<String>> _suggestionCallback(String text) async {
    if (text.isNotEmpty) {
      return widget.list.where((String topping) {
        return topping.toLowerCase().contains(text.toLowerCase());
      }).toList();
    }
    return const <String>[];
  }
}

class ChipsInput<T> extends StatefulWidget {
  const ChipsInput({
    Key? key,
    required this.values,
    this.decoration = const InputDecoration(),
    this.style,
    this.strutStyle,
    required this.chipBuilder,
    required this.onChanged,
    this.onChipTapped,
    this.onSubmitted,
    this.onTextChanged,
  }) : super(key: key);

  final List<T> values;
  final InputDecoration decoration;
  final TextStyle? style;
  final StrutStyle? strutStyle;

  final ValueChanged<List<T>> onChanged;
  final ValueChanged<T>? onChipTapped;
  final ValueChanged<String>? onSubmitted;
  final ValueChanged<String>? onTextChanged;

  final Widget Function(BuildContext context, T data) chipBuilder;

  @override
  ChipsInputState<T> createState() => ChipsInputState<T>();
}

class ChipsInputState<T> extends State<ChipsInput<T>> {
  late final ChipsInputEditingController<T> controller;

  String _previousText = '';
  TextSelection? _previousSelection;

  @override
  void initState() {
    super.initState();

    controller = ChipsInputEditingController<T>(
      <T>[...widget.values],
      widget.chipBuilder,
    );
    controller.addListener(_textListener);
  }

  @override
  void dispose() {
    controller.removeListener(_textListener);
    controller.dispose();

    super.dispose();
  }

  void _textListener() {
    final String currentText = controller.text;

    if (_previousSelection != null) {
      final int currentNumber = countReplacements(currentText);
      final int previousNumber = countReplacements(_previousText);

      final int cursorEnd = _previousSelection!.extentOffset;
      final int cursorStart = _previousSelection!.baseOffset;

      final List<T> values = <T>[...widget.values];

      if (currentNumber < previousNumber && currentNumber != values.length) {
        if (cursorStart == cursorEnd) {
          values.removeRange(cursorStart - 1, cursorEnd);
        } else {
          if (cursorStart > cursorEnd) {
            values.removeRange(cursorEnd, cursorStart);
          } else {
            values.removeRange(cursorStart, cursorEnd);
          }
        }
        widget.onChanged(values);
      }
    }

    _previousText = currentText;
    _previousSelection = controller.selection;
  }

  static int countReplacements(String text) {
    return text.codeUnits
        .where(
            (int u) => u == ChipsInputEditingController.kObjectReplacementChar)
        .length;
  }

  @override
  Widget build(BuildContext context) {
    controller.updateValues(<T>[...widget.values]);

    return TextField(
      minLines: 1,
      maxLines: 3,
      textInputAction: TextInputAction.done,
      decoration: widget.decoration,
      style: widget.style,
      strutStyle: widget.strutStyle,
      controller: controller,
      onChanged: (String value) =>
          widget.onTextChanged?.call(controller.textWithoutReplacements),
      onSubmitted: (String value) =>
          widget.onSubmitted?.call(controller.textWithoutReplacements),
    );
  }
}

class ChipsInputEditingController<T> extends TextEditingController {
  ChipsInputEditingController(this.values, this.chipBuilder)
      : super(
          text: String.fromCharCode(kObjectReplacementChar) * values.length,
        );

  static const int kObjectReplacementChar = 0xFFFE;

  List<T> values;

  final Widget Function(BuildContext context, T data) chipBuilder;

  void updateValues(List<T> values) {
    if (values.length != this.values.length) {
      final String char = String.fromCharCode(kObjectReplacementChar);
      final int length = values.length;
      value = TextEditingValue(
        text: char * length,
        selection: TextSelection.collapsed(offset: length),
      );
      this.values = values;
    }
  }

  String get textWithoutReplacements {
    final String char = String.fromCharCode(kObjectReplacementChar);
    return text.replaceAll(RegExp(char), '');
  }

  @override
  TextSpan buildTextSpan(
      {required BuildContext context,
      TextStyle? style,
      required bool withComposing}) {
    final Iterable<WidgetSpan> chipWidgets =
        values.map((T v) => WidgetSpan(child: chipBuilder(context, v)));

    return TextSpan(
      style: style,
      children: <InlineSpan>[
        ...chipWidgets,
        if (textWithoutReplacements.isNotEmpty)
          TextSpan(text: textWithoutReplacements)
      ],
    );
  }
}

class ToppingSuggestion extends StatelessWidget {
  const ToppingSuggestion(this.topping, {super.key, this.onTap});

  final String topping;
  final ValueChanged<String>? onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      key: ObjectKey(topping),
      leading: CircleAvatar(
        child: Text(
          topping[0].toUpperCase(),
        ),
      ),
      title: Text(topping),
      onTap: () {
        if (onTap != null) onTap!(topping);
      },
    );
  }
}

class ToppingInputChip extends StatelessWidget {
  const ToppingInputChip({
    Key? key,
    required this.item,
    this.onDeleted,
    this.onSelected,
  }) : super(key: key);

  final String item;
  final VoidCallback? onDeleted;
  final VoidCallback? onSelected;

  @override
  Widget build(BuildContext context) {
    return InputChip(
      label: Text(item),
      onDeleted: () => onDeleted?.call(),
      onSelected: (_) => onSelected?.call(),
    );
  }
}
