library nation_code_picker;

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

  /// The [NationCodes] that will be displayed at the top of the picker list.
  final NationCodes? primaryNationCode;

  /// Callback function that is called when a nation code is selected.
  /// If null, no action is taken when a nation is selected.
  final void Function(NationCodes)? onNationSelected;

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

  /// The text style for the dial code.
  /// If provided, used to style the dial text.
  /// Defaults to the system style if not provided.
  final TextStyle? dialCodeTextStyle;

  /// The scale of the flag image.
  /// Must be between 0.1 and 1.0 (inclusive).
  /// 0.5 corresponds to size 15, 0.1 to smaller size, and 1.0 to larger size.
  /// If not provided, defaults to `0.5`.
  final double? flagScale;

  /// Asserts that [flagScale] is within the valid range if provided.
  void _assertFlagScale() {
    assert(
      flagScale == null || (flagScale! >= 0.1 && flagScale! <= 1.0),
      'flagScale must be between 0.1 and 1.0 (inclusive)',
    );
  }

  /// Converts the scale value to actual pixel size.
  /// 0.1 -> 30 pixels (maximum size, since FlagComponent uses inverse scaling)
  /// 0.5 -> 15 pixels (default size)
  /// 1.0 -> 3 pixels (minimum size, since FlagComponent uses inverse scaling)
  double _getScaledSize() {
    final scale = flagScale ?? 0.5;
    // Inverse linear interpolation: 0.1 maps to 30, 0.5 maps to 15, 1.0 maps to 3
    // Formula: size = 30 - (scale - 0.1) * (30 - 3) / (1.0 - 0.1)
    return 30 - (scale - 0.1) * 27 / 0.9;
  }

  /// Creates a [NationCodePicker] widget.
  ///
  /// The [defaultNationCode] must not be null.
  /// The [flagScale] must be between 0.1 and 1.0 (inclusive).
  /// The default values are:
  /// * `dialCodeColor`: `CupertinoColors.label`
  /// * `dialCodeFontFamily`: `null` (system default)
  /// * `dialCodeFontWeight`: `FontWeight.normal`
  /// * `hideFlag`: `false`
  /// * `hideDialCode`: `false`
  /// * `title`: `null`
  /// * `locale`: `null`
  /// * `flagScale`: `0.5` (corresponds to size 15)
  NationCodePicker({
    super.key,
    required this.defaultNationCode,
    this.primaryNationCode,
    this.onNationSelected,
    this.hideSearch = false,
    this.hideFlag = false,
    this.hideDialCode = false,
    this.title,
    this.locale,
    this.dialCodeTextStyle,
    this.flagScale = 0.5,
  }) {
    _assertFlagScale();
  }

  @override
  State<NationCodePicker> createState() => _NationCodePickerState();
}

class _NationCodePickerState extends State<NationCodePicker>
    with _NationCodePickerMixin {
  List<NationCodes> _getInitialNationCodes() {
    final list = List<NationCodes>.from(NationCodes.values);
    if (widget.primaryNationCode != null &&
        list.contains(widget.primaryNationCode)) {
      list.remove(widget.primaryNationCode);
      list.insert(0, widget.primaryNationCode!);
    }
    return list;
  }

  @override
  Widget build(BuildContext context) {
    return CupertinoButton(
      padding: EdgeInsets.zero,
      minimumSize: Size.zero,
      onPressed: () {
        _stateNotifier.value = _stateNotifier.value
            .copyWith(searchedNationCodes: _getInitialNationCodes());
        NationCodeDialogExtension.showNationCodesDialog(
          context,
          stateNotifier: _stateNotifier,
          defaultNationCode: widget.defaultNationCode,
          primaryNationCode: widget.primaryNationCode,
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
              ? const SizedBox.shrink()
              : Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (!widget.hideFlag)
                      FlagComponent(
                        nation: nation,
                        scale: widget._getScaledSize(),
                      ),
                    if (!widget.hideFlag && !widget.hideDialCode)
                      const SizedBox(width: 5),
                    if (!widget.hideDialCode)
                      Text(
                        nation.dialCode,
                        style: widget.dialCodeTextStyle,
                      ),
                  ],
                );
        },
      ),
    );
  }
}
