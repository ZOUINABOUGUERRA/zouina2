import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/constants/fonts.dart';

/// ويدجت AppBar مخصص نستعملوه في كامل التطبيق
/// يقدر يكون فيه عنوان، أزرار إضافية، و اختيار تمركز العنوان
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title; // نص العنوان لي يظهر فالنص
  final bool centerTitle; // هل العنوان يكون فالنص ولا لا
  final List<Widget>? actions; // أزرار إضافية فالجهة اليمنى (Icons مثلا)

  const CustomAppBar({
    super.key,
    required this.title,
    this.centerTitle = true,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary, // لون خلفية AppBar (الأزرق)
      elevation: 0, // بدون ظل
      centerTitle: centerTitle, // تحديد مكان العنوان
      title: Text(
        title,
        style: AppFonts.headlineMedium, // ستايل العنوان (موجود في ملف fonts)
      ),
      actions: actions, // عرض الأزرار الإضافية (اذا موجودة)
    );
  }

  /// تحديد حجم الـ AppBar
  @override
  Size get preferredSize => const Size.fromHeight(60);
}
