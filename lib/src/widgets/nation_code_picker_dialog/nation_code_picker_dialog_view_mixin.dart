part of 'nation_code_picker_dialog_view.dart';

mixin _NationCodePickerDialogViewMixin on State<NationCodePickerDialogView> {
  void _searchCountries(String query) {
    query = query.trim().toLowerCase();
    final results = NationCodes.values.where((nation) {
      final name = NationCodeLocalization.instance
              .translate(nation.code)
              ?.toLowerCase() ??
          nation.name.toLowerCase();
      final code = nation.code.toLowerCase();
      final dialCode = nation.dialCode.toLowerCase();
      return name.contains(query) ||
          code.contains(query) ||
          dialCode.contains(query);
    }).toList();

    widget.stateNotifier.value =
        widget.stateNotifier.value.copyWith(searchedNationCodes: results);
  }

  Widget _buildSearch({EdgeInsetsGeometry? padding}) {
    return widget.hideSearch
        ? const SizedBox.shrink()
        : Padding(
            padding: padding ?? const EdgeInsets.only(left: 15),
            child: CupertinoSearchTextField(
              suffixMode: OverlayVisibilityMode.never,
              onChanged: _searchCountries,
            ),
          );
  }
}

extension NationCodeDialogExtension on NationCodePicker {
  static void showNationCodesDialog(
    BuildContext context, {
    required ValueNotifier<NationCodeState> stateNotifier,
    required NationCodes defaultNationCode,
    String? title,
    void Function(NationCodes)? onNationSelected,
    bool hideSearch = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => NationCodePickerDialogView(
        stateNotifier: stateNotifier,
        defaultNationCode: defaultNationCode,
        onNationSelected: onNationSelected,
        title: title,
        hideSearch: hideSearch,
      ),
    );
  }
}
