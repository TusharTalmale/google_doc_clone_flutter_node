
import 'package:flutter/material.dart';
import 'package:google_doc/models/presence_model.dart';
import 'package:google_doc/utils/app_colors.dart';
import 'package:google_doc/utils/app_theme.dart';

class CollaboratorAvatars extends StatelessWidget {
  final List<Presence> presences;

  const CollaboratorAvatars({
    super.key,
    required this.presences,
  });

  @override
  Widget build(BuildContext context) {
    if (presences.isEmpty) return const SizedBox.shrink();

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSizes.spaceSm,
        vertical: AppSizes.spaceXs,
      ),
      decoration: BoxDecoration(
        color: AppColors.glassDark,
        borderRadius: BorderRadius.circular(AppSizes.radiusFull),
        border: Border.all(color: AppColors.glassBorderDark),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          ...presences.take(3).map((p) => 
            Container(
              margin: const EdgeInsets.only(right: -8),
              child: Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Color(int.parse(p.color.replaceFirst('#', '0xff'))),
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: Center(
                  child: Text(
                    p.name.substring(0, 1),
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (presences.length > 3)
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.darkSurfaceVariant,
                shape: BoxShape.circle,
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Center(
                child: Text(
                  '+${presences.length - 3}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          const SizedBox(width: AppSizes.spaceXs),
          Text(
            '${presences.length} online',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
