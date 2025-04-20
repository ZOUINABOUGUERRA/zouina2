import 'package:flutter/material.dart';
import 'package:meditim_assistance/constants/colors.dart';
import 'package:meditim_assistance/constants/fonts.dart';

/// ويدجت زر رئيسي Primary Button
/// نستعمله في كامل المشروع باش الزر يجي بنفس الشكل والستايل
class PrimaryButton extends StatelessWidget {
  final String text; // نص الزر
  final VoidCallback onPressed; // دالة تتنفذ كي يضغط المستخدم على الزر
  final double? width; // عرض الزر (اختياري)
  final double? height; // طول الزر (اختياري)

  const PrimaryButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width:
          width ?? double.infinity, // العرض: كامل الشاشة إلا إذا حددناه من برا
      height: height ?? 55, // الطول: 55 إلا إذا حددناه من برا
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary, // لون خلفية الزر
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12), // الحواف مدورة بـ 12
          ),
          elevation: 0, // بدون ظل
        ),
        onPressed: onPressed, // شنو يدير كي نضغط على الزر
        child: Text(
          text, // النص لي يبان داخل الزر
          style: AppFonts.buttonText, // ستايل النص موجود في fonts.dart
        ),
      ),
    );
  }
}
