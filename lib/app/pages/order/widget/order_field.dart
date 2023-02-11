// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:delivery_app/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';

class OrderField extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final FormFieldValidator validator;
  final String hintText;

  const OrderField({
    super.key,
    required this.title,
    required this.controller,
    required this.validator,
    required this.hintText,
  });

  @override
  Widget build(BuildContext context) {
    const defaultBorder =
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 35,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 3.0),
          child: Text(
            title,
            style: context.textStyles.textRegular
                .copyWith(fontSize: 16, overflow: TextOverflow.ellipsis),
          ),
        ),
        TextFormField(
          controller: controller,
          validator: validator,
          decoration: InputDecoration(
            hintText: hintText,
            border: defaultBorder,
            enabledBorder: defaultBorder,
            focusedBorder: defaultBorder,
          ),
        ),
      ],
    );
  }
}