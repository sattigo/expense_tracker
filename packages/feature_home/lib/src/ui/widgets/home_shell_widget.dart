import 'package:core_l10n/core_l10n.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeShellWidget extends StatelessWidget {
  const HomeShellWidget({required StatefulNavigationShell navigationShell, super.key})
    : _navigationShell = navigationShell;

  final StatefulNavigationShell _navigationShell;

  @override
  Widget build(BuildContext context) {
    final l10n = S.of(context)!;

    return Scaffold(
      body: _navigationShell,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _navigationShell.currentIndex,
        onTap: (index) => _navigationShell.goBranch(index, initialLocation: index == _navigationShell.currentIndex),
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.list), label: l10n.homeTabList),
          BottomNavigationBarItem(icon: const Icon(Icons.bar_chart), label: l10n.homeTabChart),
        ],
      ),
    );
  }
}
