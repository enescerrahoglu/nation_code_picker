import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nation_code_picker/nation_code_picker.dart';
import 'package:nation_code_picker/src/nation_code_state.dart';
import 'package:nation_code_picker/src/components/flag_component.dart';
part 'nation_code_picker_dialog_view_mixin.dart';

class NationCodePickerDialogView extends StatefulWidget {
  final ValueNotifier<NationCodeState> stateNotifier;
  final NationCodes defaultNationCode;
  final void Function(NationCodes)? onNationSelected;

  const NationCodePickerDialogView({
    super.key,
    required this.stateNotifier,
    required this.defaultNationCode,
    this.onNationSelected,
  });

  @override
  State<NationCodePickerDialogView> createState() =>
      _NationCodePickerDialogViewState();
}

class _NationCodePickerDialogViewState extends State<NationCodePickerDialogView>
    with _NationCodePickerDialogViewMixin {
  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            backgroundColor: Colors.transparent,
            automaticallyImplyLeading: false,
            title: CupertinoSearchTextField(
              suffixMode: OverlayVisibilityMode.never,
              onChanged: _searchCountries,
            ),
            actions: [
              CupertinoButton(
                child: const Icon(CupertinoIcons.xmark),
                onPressed: () {
                  if (Navigator.canPop(context)) Navigator.pop(context);
                },
              ),
            ],
          ),
          body: ValueListenableBuilder<NationCodeState>(
            valueListenable: widget.stateNotifier,
            builder: (context, state, _) {
              return state.searchedNationCodes.isEmpty
                  ? const Center(
                      child: Icon(
                        CupertinoIcons.flag_slash_fill,
                        size: 30,
                      ),
                    )
                  : CupertinoScrollbar(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(10),
                        itemCount: state.searchedNationCodes.length,
                        itemBuilder: (context, index) {
                          final nation = state.searchedNationCodes[index];
                          return ListTile(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            onTap: () {
                              final selected = nation;
                              widget.stateNotifier.value = widget
                                  .stateNotifier.value
                                  .copyWith(selectedNationCode: selected);

                              if (widget.onNationSelected != null) {
                                widget.onNationSelected!(selected);
                              }

                              if (Navigator.canPop(context)) {
                                Navigator.pop(context);
                              }
                            },
                            leading: FlagComponent(nation: nation),
                            title: Text(nation.name),
                            trailing: Text(
                              nation.dialCode,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) => const Divider(
                          thickness: 0.5,
                          height: 0,
                          indent: 12,
                          endIndent: 12,
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
