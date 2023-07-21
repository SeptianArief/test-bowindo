import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:test_bowindo/shared/style_helper.dart';

class FormHelper {
  static Widget dropdownForm(BuildContext context,
      {String? data,
      IconData? customIcons,
      Color? customColor,
      bool useBorder = true,
      Widget? customWidget,
      EdgeInsetsGeometry? customPadding,
      required String hintText}) {
    return Container(
      width: double.infinity,
      padding: customPadding ??
          EdgeInsets.symmetric(vertical: 12.5, horizontal: 12.5),
      decoration: BoxDecoration(
          color: customColor ?? Colors.white,
          borderRadius: BorderRadius.circular(6),
          border: Border.all(
              color: useBorder ? Color(0xffA5A5A5) : Colors.transparent)),
      child: Row(
        children: [
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: customWidget ??
                  Text(
                    data ?? hintText,
                    maxLines: 1,
                    style: data == null
                        ? mainFont.copyWith(
                            fontSize: 16,
                            color: Colors.black87.withOpacity(0.3),
                          )
                        : mainFont.copyWith(
                            fontSize: 16, color: Colors.black87),
                  ),
            ),
          ),
          SizedBox(width: 5),
          Icon(
            customIcons ?? Icons.keyboard_arrow_down_rounded,
            color: Color(0xFFAFBDD8),
          )
        ],
      ),
    );
  }

  static Widget dataSplit(
      {required String title,
      required String desc,
      Widget? customWidget,
      Color titleColor = Colors.black87,
      Color dataColor = Colors.black54}) {
    return Container(
      margin: const EdgeInsets.only(top: 5),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(
            flex: 4,
            child: SizedBox(
              width: double.infinity,
              child: Text(
                title,
                style: mainFont.copyWith(fontSize: 12, color: titleColor),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Flexible(
            flex: 6,
            child: SizedBox(
              width: double.infinity,
              child: customWidget ??
                  Text(
                    desc,
                    style: mainFont.copyWith(fontSize: 12, color: dataColor),
                  ),
            ),
          )
        ],
      ),
    );
  }

  static void showSnackbar(BuildContext context,
      {required String data, required Color colors}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: colors,
      content: Text(
        data,
        style: const TextStyle(color: Colors.white),
      ),
    ));
  }

  static Widget titleWithWidget(
      {double? customTitleSize,
      double? customMargin,
      bool? withHelp = false,
      String? validation,
      required String title,
      required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              title,
              style: mainFont.copyWith(
                  color: Colors.black87,
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
        SizedBox(height: customMargin ?? 5),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            widget,
            validation == null
                ? Container()
                : Text(
                    validation,
                    style: mainFont.copyWith(fontSize: 12, color: Colors.red),
                  )
          ],
        )
      ],
    );
  }

  static Widget fillButton(BuildContext context,
      {required String title, required Function() onTap, Color? customColor}) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
            color: customColor ?? Theme.of(context).primaryColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
                color: customColor ?? Theme.of(context).primaryColor)),
        alignment: Alignment.center,
        child: Text(
          title,
          style: mainFont.copyWith(
              fontSize: 16, color: Colors.white, fontWeight: FontWeight.w600),
        ),
      ),
    );
  }

  static Widget roundedTextfield(
    BuildContext context, {
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixWidget,
    bool? obscureText,
    double? customRadius,
    Widget? prefixWidget,
    String? labelText,
    bool withBorder = true,
    Function()? onEditingComplete,
    String? validation,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    String? prefixText,
    TextStyle? prefixStyle,
    FocusNode? focusNode,
    EdgeInsetsGeometry? contentPadding,
    int? maxLines,
    Color? customColorFill,
    List<TextInputFormatter>? inputFormatters,
    Function(String)? onChanged,
    bool? enabled,
    int? maxLength,
    Function()? onTap,
    required TextEditingController controller,
  }) {
    return TextFormField(
      controller: controller,
      onEditingComplete: onEditingComplete,
      enabled: enabled ?? true,
      validator: (value) {
        return validator == null ? null : validator(value!);
      },
      onChanged: onChanged,
      maxLength: maxLength,
      focusNode: focusNode,
      onTap: onTap,
      cursorColor: Theme.of(context).primaryColor,
      maxLines: maxLines ?? 1,
      keyboardType: keyboardType ?? TextInputType.text,
      obscureText: obscureText ?? false,
      inputFormatters: inputFormatters,
      style: mainFont.copyWith(fontSize: 16),
      decoration: InputDecoration(
          labelText: labelText,
          labelStyle: mainFont.copyWith(
              fontSize: 16, color: Theme.of(context).primaryColor),
          hintText: hintText,
          focusedBorder: withBorder
              ? OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Theme.of(context).primaryColor, width: 1.5),
                  borderRadius: BorderRadius.circular(customRadius ?? 6),
                )
              : null,
          fillColor: customColorFill ?? Colors.white,
          filled: true,
          prefixText: prefixText,
          prefix: prefixWidget,
          prefixStyle: prefixStyle ??
              mainFont.copyWith(
                  fontSize: 16,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold),
          contentPadding: contentPadding ??
              const EdgeInsets.symmetric(
                vertical: 12.5,
                horizontal: 12,
              ),
          errorMaxLines: 10,
          hintStyle:
              mainFont.copyWith(fontSize: 13, color: const Color(0xffB8B8B8)),
          prefixIcon: prefixIcon,
          suffixIcon: suffixWidget,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD4D4D4)),
            borderRadius: BorderRadius.circular(
              customRadius ?? 4,
            ),
          ),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Color(0xffD4D4D4)),
            borderRadius: BorderRadius.circular(
              customRadius ?? 4,
            ),
          )),
    );
  }
}
