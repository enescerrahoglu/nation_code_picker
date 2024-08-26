part of 'nation_code_picker.dart';

mixin _NationCodePickerMixin on State<NationCodePicker> {
  late ValueNotifier<List<NationCode>> searchedNationCodes;
  late ValueNotifier<NationCode?> selectedNationCode;

  @override
  void initState() {
    super.initState();
    selectedNationCode = ValueNotifier(widget.defaultNationCode);
  }

  @override
  void dispose() {
    searchedNationCodes.dispose();
    selectedNationCode.dispose();
    super.dispose();
  }

  void _searchCountries(String query) {
    query = query.trim().toLowerCase();
    final List<NationCode> results = NationCode.values.where((nation) {
      final name = nation.name.toLowerCase();
      final code = nation.code.toLowerCase();
      final dialCode = nation.dialCode.toLowerCase();
      return name.contains(query) || code.contains(query) || dialCode.contains(query);
    }).toList();

    searchedNationCodes.value = results;
  }

  void _showNationCodesDialog() {
    searchedNationCodes = ValueNotifier<List<NationCode>>(List.from(NationCode.values));
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
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
                )
              ],
            ),
            body: ValueListenableBuilder<List<NationCode>>(
              valueListenable: searchedNationCodes,
              builder: (context, value, _) {
                return searchedNationCodes.value.isEmpty
                    ? const Center(
                        child: Icon(
                          CupertinoIcons.flag_slash_fill,
                          size: 30,
                        ),
                      )
                    : CupertinoScrollbar(
                        child: ListView.separated(
                          padding: const EdgeInsets.all(10),
                          itemCount: value.length,
                          itemBuilder: (context, index) {
                            final nation = value[index];
                            return ListTile(
                              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                              onTap: () {
                                final selected = nation;
                                selectedNationCode.value = selected;
                                if (widget.onNationSelected != null) {
                                  widget.onNationSelected!(selected);
                                }

                                if (Navigator.canPop(context)) Navigator.pop(context);
                              },
                              leading: ClipRRect(
                                borderRadius: BorderRadius.circular(3),
                                child: Image.asset(
                                  'assets/flags/${nation.code.toLowerCase()}.png',
                                  package: 'nation_code_picker',
                                  fit: BoxFit.cover,
                                  scale: 1.5,
                                  errorBuilder: (context, error, stackTrace) => const Icon(CupertinoIcons.flag_fill),
                                ),
                              ),
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
      ),
    );
  }
}
