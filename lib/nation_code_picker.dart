library nation_code_picker;

import 'package:flutter/material.dart';
import 'package:nation_code_picker/nation_codes.dart';
import 'package:flutter/cupertino.dart';
part 'nation_code_picker_mixin.dart';

class NationCodePicker extends StatefulWidget {
  final NationCode defaultNationCode;
  final void Function(NationCode)? onNationSelected;
  final Color? color;
  final String? fontFamily;
  final FontWeight? fontWeight;

  const NationCodePicker({
    super.key,
    required this.defaultNationCode,
    this.onNationSelected,
    this.color,
    this.fontFamily,
    this.fontWeight,
  });

  @override
  State<NationCodePicker> createState() => _NationCodePickerState();
}

class _NationCodePickerState extends State<NationCodePicker> with _NationCodePickerMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        _showNationCodesDialog();
      },
      child: ValueListenableBuilder<NationCode?>(
        valueListenable: selectedNationCode,
        builder: (context, nation, child) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (nation != null)
                ClipRRect(
                  borderRadius: BorderRadius.circular(3),
                  child: Image.asset(
                    'assets/flags/${nation.code.toLowerCase()}.png',
                    package: 'nation_code_picker',
                    fit: BoxFit.cover,
                    scale: 2.25,
                    errorBuilder: (context, error, stackTrace) => const Icon(CupertinoIcons.flag_fill),
                  ),
                ),
              if (nation != null) const SizedBox(width: 5),
              if (nation != null)
                Text(
                  nation.dialCode,
                  style: TextStyle(
                    color: widget.color,
                    fontWeight: widget.fontWeight,
                    fontFamily: widget.fontFamily,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}
