import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/services.dart';
import '../providers/cart_provider.dart';

/// Screen allowing the user to capture an image using the camera.
class CameraScreen extends ConsumerWidget {
  /// Creates a [CameraScreen].
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final loc = AppLocalizations.of(context)!;
    return Scaffold(
      appBar: AppBar(title: Text(loc.cameraScreenTitle)),
      body: Center(
        child: Semantics(
          button: true,
          label: loc.scanButton,
          child: ElevatedButton(
            onPressed: () async {
              const channel = MethodChannel('plugins.flutter.io/camera');
              final path = await channel.invokeMethod<String>('takePicture');
              if (path != null) {
                ref.read(cartProvider.notifier).addItem(
                      CartItem(name: 'Scanned Item', price: 1.23),
                    );
              }
            },
            style: ElevatedButton.styleFrom(minimumSize: const Size(48, 48)),
            child: Text(loc.scanButton),
          ),
        ),
      ),
    );
  }
}
