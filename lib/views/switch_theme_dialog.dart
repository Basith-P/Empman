import 'package:empman/core/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SwitchThemeDialog extends ConsumerWidget {
  const SwitchThemeDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final items = [
      {
        "label": "Light",
        "value": ThemeMode.light,
      },
      {
        "label": "Dark",
        "value": ThemeMode.dark,
      },
      {
        "label": "System",
        "value": ThemeMode.system,
      },
    ];

    return SimpleDialog(
      title: const Text("Choose Theme"),
      children: [
        for (final item in items)
          RadioListTile<ThemeMode>(
            title: Text(item["label"] as String),
            value: item["value"] as ThemeMode,
            groupValue: ref.read(themeModeProvider),
            onChanged: (value) {
              ref.read(themeModeProvider.notifier).state = value!;
              Navigator.pop(context);
            },
          ),
      ],
    );
  }
}
