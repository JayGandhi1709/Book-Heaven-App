import 'dart:developer';

import 'package:book_heaven/common/chips_input.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class EditableChipField extends StatefulWidget {
  const EditableChipField({
    Key? key,
    required this.list,
    required this.decoration,
    required this.onChanged,
  }) : super(key: key);

  final List<String> list;
  final InputDecoration decoration;
  final ValueChanged<List<String>> onChanged;

  @override
  _EditableChipFieldState createState() => _EditableChipFieldState();
}

class _EditableChipFieldState extends State<EditableChipField> {
  final FocusNode _chipFocusNode = FocusNode();
  List<String> _selectedItems = [];
  List<String> _suggestions = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
          child: ChipsInput<String>(
            values: _selectedItems,
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
          .where((String topping) => !_selectedItems.contains(topping))
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
      _selectedItems.add(topping);
      _suggestions = <String>[];
    });
  }

  void _onChipTapped(String item) {}

  void _onChipDeleted(String item) {
    setState(() {
      _selectedItems.remove(item);
      _suggestions = <String>[];
    });
    // Trigger onChanged to update parent
    log("ghduygduygdvdygvduygdygudyguygyviygigifuydsgeydcusgdsvyuigudsyfvigufrtuwyidgsvcyid");
    widget.onChanged(_selectedItems);
  }

  void _onSubmitted(String text) {
    if (text.trim().isNotEmpty) {
      setState(() {
        _selectedItems.add(text.trim());
      });
      widget.onChanged(_selectedItems);
    } else {
      _chipFocusNode.unfocus();
      setState(() {
        _selectedItems = <String>[];
      });
    }
  }

  void _onChanged(List<String> data) {
    setState(() {
      _selectedItems = data;  // Update the selected chips locally
    });
    widget.onChanged(_selectedItems);  // Trigger the callback to parent
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
