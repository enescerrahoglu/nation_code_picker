import 'package:flutter/cupertino.dart';
import 'package:nation_code_picker/src/nation_codes.dart';

class FlagComponent extends StatelessWidget {
  /// [NationCodes] value specifying the flag to be displayed on the screen
  final NationCodes nation;

  /// Size scale of the flag to be displayed on the screen
  final double? scale;
  const FlagComponent({super.key, required this.nation, this.scale = 1.5});

  @override
  Widget build(BuildContext context) {
    final String flagPath = 'assets/flags/${nation.code.toLowerCase()}.png';
    return ClipRRect(
      borderRadius: BorderRadius.circular(3),
      child: Image.asset(
        flagPath,
        package: 'nation_code_picker',
        fit: BoxFit.cover,
        scale: scale,
        errorBuilder: (context, error, stackTrace) =>
            const Icon(CupertinoIcons.flag_fill),
      ),
    );
  }
}
