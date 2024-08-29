import 'package:equatable/equatable.dart';
import 'package:nation_code_picker/src/nation_codes.dart';

class NationCodeState extends Equatable {
  final List<NationCodes> searchedNationCodes;
  final NationCodes? selectedNationCode;

  const NationCodeState({
    required this.searchedNationCodes,
    this.selectedNationCode,
  });

  NationCodeState copyWith({
    List<NationCodes>? searchedNationCodes,
    NationCodes? selectedNationCode,
  }) {
    return NationCodeState(
      searchedNationCodes: searchedNationCodes ?? this.searchedNationCodes,
      selectedNationCode: selectedNationCode ?? this.selectedNationCode,
    );
  }

  @override
  List<Object?> get props => [searchedNationCodes, selectedNationCode];
}
