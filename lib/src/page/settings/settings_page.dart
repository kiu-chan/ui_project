import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:ui_project/src/providers/language_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final languageProvider = Provider.of<LanguageProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context)!.settings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              AppLocalizations.of(context)!.language,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 10),
            DropdownButton<String>(
              value: languageProvider.currentLanguage,
              items: [
                DropdownMenuItem(
                  value: 'en',
                  child: Text(AppLocalizations.of(context)!.english),
                ),
                DropdownMenuItem(
                  value: 'vi',
                  child: Text(AppLocalizations.of(context)!.vietnamese),
                ),
              ],
              onChanged: (String? newValue) {
                if (newValue != null) {
                  languageProvider.changeLanguage(newValue);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}