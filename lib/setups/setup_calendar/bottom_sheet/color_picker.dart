import 'package:flutter/material.dart';

import '../../../database/drift_calendar/drift_database.dart';

typedef ColorIdSetter = void Function(int id);

class BottomSheetColorPicker extends StatelessWidget {
  const BottomSheetColorPicker({
    required this.colors,
    required this.selectedColorId,
    required this.colorIdSetter,
    Key? key,
  }) : super(key: key);

  final List<CategoryColor> colors;
  final int? selectedColorId;
  final ColorIdSetter colorIdSetter;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0, // left-right spacing
      runSpacing: 10.0, // Top-bottom spacing
      children: colors
          .map(
            (e) => GestureDetector(
              onTap: () {
                colorIdSetter(e.id);
              },
              child: renderColor(
                e,
                selectedColorId == e.id,
              ),
            ),
          )
          .toList(),
    );
  }

  Widget renderColor(CategoryColor color, bool isSelected) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Color(
          int.parse(
            'FF${color.hexCode}',
            radix: 16,
          ),
        ),
        border: isSelected ? Border.all(color: Colors.black, width: 4.0) : null,
      ),
      width: 32.0,
      height: 32.0,
    );
  }
}
