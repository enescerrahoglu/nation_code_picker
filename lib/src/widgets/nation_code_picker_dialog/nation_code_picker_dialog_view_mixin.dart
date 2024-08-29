part of 'nation_code_picker_dialog_view.dart';

mixin _NationCodePickerDialogViewMixin on State<NationCodePickerDialogView> {
  void _searchCountries(String query) {
    query = query.trim().toLowerCase();
    final results = NationCodes.values.where((nation) {
      final name = nation.name.toLowerCase();
      final code = nation.code.toLowerCase();
      final dialCode = nation.dialCode.toLowerCase();
      return name.contains(query) ||
          code.contains(query) ||
          dialCode.contains(query);
    }).toList();

    widget.stateNotifier.value =
        widget.stateNotifier.value.copyWith(searchedNationCodes: results);
  }
}

extension NationCodeDialogExtension on NationCodePicker {
  static void showNationCodesDialog(
    BuildContext context,
    ValueNotifier<NationCodeState> stateNotifier,
    NationCodes defaultNationCode,
    void Function(NationCodes)? onNationSelected,
  ) {
    showDialog(
      context: context,
      builder: (context) => NationCodePickerDialogView(
        stateNotifier: stateNotifier,
        defaultNationCode: defaultNationCode,
        onNationSelected: onNationSelected,
      ),
    );
  }
}
