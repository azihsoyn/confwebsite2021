import 'package:confwebsite2021/responsive_layout_builder.dart';
import 'package:confwebsite2021/router/index.dart';
import 'package:confwebsite2021/widgets/license_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:gap/gap.dart';
import 'package:url_launcher/url_launcher.dart';

class Footer extends StatelessWidget {
  const Footer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final appLocalizations = AppLocalizations.of(context)!;
    final footerLinks = <Map<String, String>>[
      {
        'name': appLocalizations.codeOfConduct,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Code-of-Conduct.ja.html',
      },
      {
        'name': appLocalizations.privacyPolicy,
        'url':
            'https://flutterkaigi.github.io/flutterkaigi/Privacy-Policy.ja.html',
      },
      {
        'name': appLocalizations.contactUs,
        'url':
            'https://docs.google.com/forms/d/e/1FAIpQLSemYPFEWpP8594MWI4k3Nz45RJzMS7pz1ufwtnX4t3V7z2TOw/viewform',
      },
    ];

    final footerItem = footerLinks.map((link) {
      return _FooterButton(
          message: link['url']!,
          text: link['name']!,
          onPressed: () async {
            await launch(link['url']!);
          });
    }).toList()
      ..add(
        _FooterButton(
            message: appLocalizations.staff,
            text: appLocalizations.staff,
            onPressed: () {
              Navigator.of(context).pushNamed(staffRoute().settings.name!);
            }),
      );

    return ResponsiveLayoutBuilder(builder: (context, layout, width) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          if (layout == ResponsiveLayout.slim)
            Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: footerItem)
          else
            Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: footerItem),
          const Gap(8),
          const LicenseButton(),
          const Gap(8),
          Text(appLocalizations.copyright),
        ],
      );
    });
  }
}

class _FooterButton extends StatelessWidget {
  const _FooterButton({
    Key? key,
    required this.message,
    required this.text,
    required this.onPressed,
  }) : super(key: key);

  final String message;
  final String text;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: message,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: ElevatedButton(
          onPressed: onPressed,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                padding: MaterialStateProperty.resolveWith<EdgeInsets>(
                  (states) => const EdgeInsets.all(20),
                ),
              ),
          child: Text(text),
        ),
      ),
    );
  }
}
