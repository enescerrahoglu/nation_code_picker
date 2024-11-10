library nation_code_picker;

import 'package:flutter/material.dart';
import 'package:nation_code_picker/flag_component.dart';
import 'package:nation_code_picker/src/localization/nation_code_localization.dart';
import 'package:nation_code_picker/src/nation_codes.dart';
import 'package:nation_code_picker/src/nation_code_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:nation_code_picker/src/widgets/nation_code_picker_dialog/nation_code_picker_dialog_view.dart';

export 'package:nation_code_picker/nation_code_picker.dart'
    show NationCodePicker;
export 'package:nation_code_picker/src/nation_codes.dart' show NationCodes;
export 'package:nation_code_picker/src/nation_code_state.dart'
    hide NationCodeState;
export 'package:nation_code_picker/flag_component.dart' hide FlagComponent;
export 'package:nation_code_picker/src/widgets/nation_code_picker_dialog/nation_code_picker_dialog_view.dart'
    hide NationCodePickerDialogView, NationCodeDialogExtension;

part 'nation_code_picker_mixin.dart';

final class NationCodePicker extends StatefulWidget {
  /// The default [NationCodes] to be selected when the picker is first shown.
  final NationCodes defaultNationCode;

  /// Callback function that is called when a nation code is selected.
  /// If null, no action is taken when a nation is selected.
  final void Function(NationCodes)? onNationSelected;

  /// The color of the text displaying the nation's dial code.
  /// Defaults to [CupertinoColors.label].
  final Color? dialCodeColor;

  /// The font family for the text displaying the nation's dial code.
  /// Defaults to the system font.
  final String? dialCodeFontFamily;

  /// The font weight for the text displaying the nation's dial code.
  /// Defaults to [FontWeight.normal].
  final FontWeight? dialCodeFontWeight;

  /// Whether the textfield that provides the search feature is hidden or not.
  /// Defaults to `false`, meaning the search bar is shown.
  final bool hideSearch;

  /// Whether to hide the flag representing the selected nation.
  /// Defaults to `false`, meaning the flag is shown.
  final bool hideFlag;

  /// Whether to hide the dial code of the selected nation.
  /// Defaults to `false`, meaning the dial code is shown.
  final bool hideDialCode;

  /// The title of the picker dialog.
  /// If not provided, is not used.
  final String? title;

  /// The locale to be used for displaying the nation names.
  /// If not provided, default nation names are shown.
  final Locale? locale;

  /// Creates a [NationCodePicker] widget.
  ///
  /// The [defaultNationCode] must not be null.
  /// The default values are:
  /// * `dialCodeColor`: `CupertinoColors.label`
  /// * `dialCodeFontFamily`: `null` (system default)
  /// * `dialCodeFontWeight`: `FontWeight.normal`
  /// * `hideFlag`: `false`
  /// * `hideDialCode`: `false`
  /// * `title`: `null`
  /// * `locale`: `null`
  const NationCodePicker({
    super.key,
    required this.defaultNationCode,
    this.onNationSelected,
    this.dialCodeColor,
    this.dialCodeFontFamily,
    this.dialCodeFontWeight,
    this.hideSearch = false,
    this.hideFlag = false,
    this.hideDialCode = false,
    this.title,
    this.locale,
  });

  @override
  State<NationCodePicker> createState() => _NationCodePickerState();
}

class _NationCodePickerState extends State<NationCodePicker>
    with _NationCodePickerMixin {
  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minSize: 0,
      onPressed: () {
        _stateNotifier.value = _stateNotifier.value
            .copyWith(searchedNationCodes: List.from(NationCodes.values));
        NationCodeDialogExtension.showNationCodesDialog(
          context,
          stateNotifier: _stateNotifier,
          defaultNationCode: widget.defaultNationCode,
          onNationSelected: widget.onNationSelected,
          title: widget.title,
          hideSearch: widget.hideSearch,
        );
      },
      child: ValueListenableBuilder<NationCodeState>(
        valueListenable: _stateNotifier,
        builder: (context, state, child) {
          final nation = state.selectedNationCode;
          return nation == null
              ? const SizedBox()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!widget.hideFlag)
                      FlagComponent(nation: nation, scale: 15),
                    if (!widget.hideFlag && !widget.hideDialCode)
                      const SizedBox(width: 5),
                    if (!widget.hideDialCode)
                      Text(
                        nation.dialCode,
                        style: TextStyle(
                          color: widget.dialCodeColor,
                          fontWeight: widget.dialCodeFontWeight,
                          fontFamily: widget.dialCodeFontFamily ??
                              Theme.of(context)
                                  .textTheme
                                  .titleMedium
                                  ?.fontFamily,
                        ),
                      ),
                  ],
                );
        },
      ),
    );
  }
}
