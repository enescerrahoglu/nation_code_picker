part of 'nation_code_picker.dart';

mixin _NationCodePickerMixin on State<NationCodePicker> {
  late ValueNotifier<NationCodeState> _stateNotifier;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration.zero, () async {
      if (widget.locale != null) {
        await NationCodeLocalization.instance.load(widget.locale);
      }
    });

    _stateNotifier = ValueNotifier(
      NationCodeState(
        searchedNationCodes: List.from(NationCodes.values),
        selectedNationCode: widget.defaultNationCode,
      ),
    );
  }

  @override
  void dispose() {
    _stateNotifier.dispose();
    super.dispose();
  }
}
