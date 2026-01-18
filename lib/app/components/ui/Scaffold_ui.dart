import 'package:estacionaqui/app/components/ui/soft_bacground_decoration_ui.dart';
import 'package:estacionaqui/app/utils/app_colors.dart';
import 'package:flutter/material.dart';

class ScaffoldUI extends StatelessWidget {
  final String title;
  final Widget body;
  final Color? backgroundColor;
  final bool showBackButton;
  final Widget? floatingActionButton;
  final Drawer? drawer;
  final AppBar? appBar;
  final FloatingActionButtonLocation? floatingActionButtonLocation;

  const ScaffoldUI({
    super.key,
    required this.body,
    this.title = 'AppBar',
    this.backgroundColor,
    this.showBackButton = true,
    this.floatingActionButton,
    this.drawer,
    this.appBar,
    this.floatingActionButtonLocation,
  });

  @override
  Widget build(BuildContext context) {
    final themeBackground =
        backgroundColor ?? AppColors.mentalEase.withOpacity(0.35);

    return Scaffold(
      backgroundColor: themeBackground,
      drawer: drawer,
      appBar:
          appBar ??
          AppBar(
            elevation: 0,
            centerTitle: true,
            backgroundColor: AppColors.mentalEase.withOpacity(0.18),
            foregroundColor: Colors.white,
            leading:
                showBackButton
                    ? IconButton(
                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                      onPressed: () => Navigator.of(context).maybePop(),
                    )
                    : null,
            title: Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: 0.3,
              ),
            ),
          ),
      body: Stack(
        children: [
          const SoftBackgroundDecoration(),
          SafeArea(
            child: Padding(padding: const EdgeInsets.all(16), child: body),
          ),
        ],
      ),
      floatingActionButton: floatingActionButton,
      floatingActionButtonLocation: floatingActionButtonLocation,
    );
  }
}
