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

    if (widget.primaryNationCode != null &&
        results.contains(widget.primaryNationCode)) {
      results.remove(widget.primaryNationCode);
      results.insert(0, widget.primaryNationCode!);
    }

    widget.stateNotifier.value =
        widget.stateNotifier.value.copyWith(searchedNationCodes: results);
  }

  Widget _buildSearchBar(
      {EdgeInsetsGeometry? padding,
      TextStyle? searchBarTextStyle,
      TextStyle? searchBarPlaceholderStyle}) {
    return widget.hideSearch
        ? const SizedBox.shrink()
        : Padding(
            padding: padding ?? const EdgeInsets.only(left: 15),
            child: CupertinoSearchTextField(
              style: searchBarTextStyle,
              placeholderStyle: searchBarPlaceholderStyle,
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
    NationCodes? primaryNationCode,
    String? title,
    void Function(NationCodes)? onNationSelected,
    bool hideSearch = false,
  }) {
    showDialog(
      context: context,
      builder: (context) => NationCodePickerDialogView(
        stateNotifier: stateNotifier,
        defaultNationCode: defaultNationCode,
        primaryNationCode: primaryNationCode,
        onNationSelected: onNationSelected,
        title: title,
        hideSearch: hideSearch,
      ),
    );
  }
}
