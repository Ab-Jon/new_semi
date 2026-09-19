import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:semi_bill/ui/ionicons.dart';
import 'package:semi_bill/themes/app_theme.dart';

class SemiButton extends StatelessWidget {
  const SemiButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.expand = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final bool expand;

  @override
  Widget build(BuildContext context) {
    final child = loading
        ? const SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2,
              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
            ),
          )
        : Text(label);

    final button = ElevatedButton(
      onPressed: loading ? null : onPressed,
      child: child,
    );

    if (!expand) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}

class SemiField extends StatelessWidget {
  const SemiField({
    super.key,
    required this.controller,
    this.label,
    this.hint,
    this.obscure = false,
    this.onToggleObscure,
    this.keyboardType,
    this.textInputAction,
    this.prefix,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String? label;
  final String? hint;
  final bool obscure;
  final VoidCallback? onToggleObscure;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final Widget? prefix;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      enabled: enabled,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        prefixIcon: prefix,
        suffixIcon: onToggleObscure == null
            ? null
            : IconButton(
                splashRadius: 20,
                icon: Icon(
                  obscure ? Icons.visibility_off_outlined : Icons.visibility_outlined,
                ),
                onPressed: onToggleObscure,
              ),
      ),
    );
  }
}

class SemiCard extends StatelessWidget {
  const SemiCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.margin,
    this.onTap,
  });

  final Widget child;
  final EdgeInsets padding;
  final EdgeInsets? margin;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final card = Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: context.cardColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: context.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 18,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: child,
    );
    if (onTap == null) return card;
    return GestureDetector(onTap: onTap, child: card);
  }
}

class SemiPage extends StatelessWidget {
  const SemiPage({
    super.key,
    required this.child,
    this.title,
    this.actions,
    this.leading,
    this.padding,
    this.bottom,
    this.floating,
  });

  final Widget child;
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final EdgeInsets? padding;
  final Widget? bottom;
  final Widget? floating;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.pageBg,
      appBar: title == null
          ? null
          : AppBar(
              title: Text(title!),
              leading: leading,
              actions: actions,
            ),
      floatingActionButton: floating,
      bottomNavigationBar: bottom,
      body: child,
    );
  }
}

class SemiAuthHeader extends StatelessWidget {
  const SemiAuthHeader({
    super.key,
    required this.lead,
    required this.accent,
    this.subtitle,
  });

  final String lead;
  final String accent;
  final String? subtitle;

  @override
  Widget build(BuildContext context) {
    final isLight = !context.isDark;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Image.asset(
          isLight ? 'assets/launchers/logo.png' : 'assets/launchers/logo_dark.png',
          height: 44,
        ),
        const SizedBox(height: 36),
        RichText(
          text: TextSpan(
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w800,
                  fontSize: 32,
                  color: Theme.of(context).extension<AppColors>()!.textPrimary,
                ),
            children: [
              TextSpan(text: lead),
              TextSpan(
                text: accent,
                style: TextStyle(color: context.brand),
              ),
            ],
          ),
        ),
        if (subtitle != null) ...[
          const SizedBox(height: 8),
          Text(
            subtitle!,
            style: TextStyle(
              fontSize: 14,
              color: Theme.of(context).extension<AppColors>()!.muted,
            ),
          ),
        ],
      ],
    );
  }
}

class SemiIconAction extends StatelessWidget {
  const SemiIconAction({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Column(
        children: [
          Container(
            height: 56,
            width: 56,
            decoration: BoxDecoration(
              color: context.isDark ? SemiColors.surfaceDark : Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: context.isDark
                  ? []
                  : [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.06),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
            ),
            child: Icon(icon, color: context.brand, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class SemiServiceTile extends StatelessWidget {
  const SemiServiceTile({
    super.key,
    required this.icon,
    required this.label,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 48,
            width: 48,
            decoration: BoxDecoration(
              color: context.isDark
                  ? SemiColors.surfaceDark
                  : SemiColors.brand.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: context.brand, size: 22),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }
}

class SemiPinPad extends StatelessWidget {
  const SemiPinPad({
    super.key,
    required this.onDigit,
    required this.onBackspace,
  });

  final ValueChanged<String> onDigit;
  final VoidCallback onBackspace;

  @override
  Widget build(BuildContext context) {
    const keys = [
      ['1', '2', '3'],
      ['4', '5', '6'],
      ['7', '8', '9'],
      ['', '0', 'del'],
    ];
    return Column(
      children: keys
          .map(
            (row) => Row(
              children: row.map((key) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8),
                    child: key.isEmpty
                        ? const SizedBox(height: 56)
                        : InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              HapticFeedback.selectionClick();
                              if (key == 'del') {
                                onBackspace();
                              } else {
                                onDigit(key);
                              }
                            },
                            child: SizedBox(
                              height: 56,
                              child: Center(
                                child: key == 'del'
                                    ? Icon(Ionicons.backspace_outline, color: context.brand)
                                    : Text(
                                        key,
                                        style: const TextStyle(
                                          fontSize: 24,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                              ),
                            ),
                          ),
                  ),
                );
              }).toList(),
            ),
          )
          .toList(),
    );
  }
}

class SemiListTile extends StatelessWidget {
  const SemiListTile({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return SemiMenuRow(
      icon: icon,
      title: title,
      subtitle: subtitle,
      onTap: onTap,
      trailing: trailing,
      showDivider: showDivider,
    );
  }
}

/// Figma settings/security row: faint lavender icon wash + chevron.
class SemiMenuRow extends StatelessWidget {
  const SemiMenuRow({
    super.key,
    required this.icon,
    required this.title,
    this.subtitle,
    this.onTap,
    this.trailing,
    this.showDivider = true,
  });

  final IconData icon;
  final String title;
  final String? subtitle;
  final VoidCallback? onTap;
  final Widget? trailing;
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            child: Row(
              children: [
                Container(
                  height: 36,
                  width: 36,
                  decoration: BoxDecoration(
                    color: context.iconWash,
                    shape: BoxShape.circle,
                  ),
                  child: Icon(icon, size: 18, color: context.iconTint),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      if (subtitle != null) ...[
                        const SizedBox(height: 2),
                        Text(
                          subtitle!,
                          style: TextStyle(
                            fontSize: 12,
                            color: Theme.of(context).extension<AppColors>()!.muted,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                trailing ??
                    Icon(
                      Icons.chevron_right,
                      size: 22,
                      color: context.isDark
                          ? Colors.white38
                          : const Color(0xFFC5C0CE),
                    ),
              ],
            ),
          ),
        ),
        if (showDivider)
          Divider(
            height: 1,
            thickness: 1,
            indent: 66,
            endIndent: 16,
            color: context.hairline,
          ),
      ],
    );
  }
}

class SemiGroupCard extends StatelessWidget {
  const SemiGroupCard({
    super.key,
    required this.children,
    this.margin,
  });

  final List<Widget> children;
  final EdgeInsets? margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin ?? const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: context.isDark ? SemiColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(22),
        boxShadow: context.isDark
            ? []
            : [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.04),
                  blurRadius: 20,
                  offset: const Offset(0, 8),
                ),
              ],
      ),
      child: Column(children: children),
    );
  }
}

class SemiBackButton extends StatelessWidget {
  const SemiBackButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        Icons.arrow_back_ios_new,
        size: 18,
        color: Theme.of(context).extension<AppColors>()!.textPrimary,
      ),
      onPressed: () => Navigator.maybePop(context),
    );
  }
}

/// Constrains Flutter web to a 390px phone so screens match Figma frames.
class PhoneShell extends StatelessWidget {
  const PhoneShell({super.key, required this.child});

  final Widget child;

  static const double width = 390;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final useFrame = size.width > width + 24;
    if (!useFrame) return child;

    final framed = Size(width, size.height);
    return ColoredBox(
      color: SemiColors.phoneChrome,
      child: Center(
        child: Container(
          width: width,
          height: size.height,
          decoration: BoxDecoration(
            color: Colors.black,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.4),
                blurRadius: 40,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: MediaQuery(
            data: MediaQuery.of(context).copyWith(size: framed),
            child: child,
          ),
        ),
      ),
    );
  }
}

class SemiNavBar extends StatelessWidget {
  const SemiNavBar({
    super.key,
    required this.index,
    required this.onChanged,
  });

  final int index;
  final ValueChanged<int> onChanged;

  static const _items = [
    (Ionicons.home_outline, Ionicons.home, 'Home'),
    (Ionicons.briefcase_outline, Ionicons.briefcase, 'Services'),
    (Ionicons.wallet_outline, Ionicons.wallet, 'Wallet'),
    (Ionicons.settings_outline, Ionicons.settings, 'Settings'),
  ];

  @override
  Widget build(BuildContext context) {
    final bar = context.isDark ? SemiColors.navBarDark : SemiColors.navBar;
    return Container(
      height: 64,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: bar,
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.22),
            blurRadius: 18,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Row(
        children: List.generate(_items.length, (i) {
          final selected = index == i;
          final item = _items[i];
          return Expanded(
            flex: selected ? 3 : 2,
            child: GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onChanged(i),
              child: Center(
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  height: 48,
                  padding: EdgeInsets.symmetric(horizontal: selected ? 14 : 0),
                  decoration: BoxDecoration(
                    color: selected ? SemiColors.navSelected : Colors.transparent,
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        selected ? item.$2 : item.$1,
                        size: 22,
                        color: selected ? SemiColors.brand : Colors.white,
                      ),
                      if (selected) ...[
                        const SizedBox(width: 6),
                        Text(
                          item.$3,
                          style: const TextStyle(
                            color: SemiColors.brand,
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
