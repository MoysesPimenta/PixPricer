import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/// Screen allowing the user to capture an image using the camera.
class CameraScreen extends StatelessWidget {
  /// Creates a [CameraScreen].
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.cameraScreenTitle)),
      body: Center(
        child: Semantics(
          button: true,
          label: loc.scanButton,
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
            child: Text(loc.scanButton),
          ),
        ),
      ),
    );
  }
}
