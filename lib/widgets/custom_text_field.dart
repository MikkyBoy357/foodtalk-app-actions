import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final double? width;
  final double height;
  final String hintText;
  final Widget? prefixIcon;
  final TextEditingController? controller;
  final int minLines;
  final int maxLines;
  final bool obscureText;
  final bool enabled;
  final FormFieldValidator<String>? validateFunction;
  final void Function(String)? onSaved, onChange;
  final TextInputType? textInputType;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode, nextFocusNode;
  final VoidCallback? submitAction;
  final bool enableErrorMessage;
  final bool? streamText;

  const CustomTextField({
    Key? key,
    this.width,
    this.height = 50,
    required this.hintText,
    this.prefixIcon,
    this.controller,
    this.minLines = 1,
    this.maxLines = 1,
    this.obscureText = false,
    this.enabled = true,
    required this.validateFunction,
    this.onSaved,
    this.onChange,
    this.textInputType,
    this.textInputAction,
    this.focusNode,
    this.nextFocusNode,
    this.submitAction,
    this.enableErrorMessage = true,
    this.streamText,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String error = '';
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Card(
          // elevation: 4.0,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(6),
            ),
          ),
          child: Container(
            height: widget.maxLines != 1 ? 35 : widget.height,
            width: widget.width ?? MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey[400] ?? Colors.grey,
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: Padding(
              padding: EdgeInsets.only(
                  left: widget.prefixIcon == null ? 15.0 : 0.0, right: 10),
              child: Center(
                child: TextFormField(
                  autovalidateMode: AutovalidateMode.disabled,
                  textCapitalization: TextCapitalization.sentences,
                  // initialValue: widget.initialValue,
                  enabled: widget.enabled,
                  onChanged: (val) {
                    error = widget.validateFunction!(val) ?? '';
                    setState(() {});
                    if (widget.streamText == true) {
                      widget.onChange!(val);
                    }
                    widget.onSaved!(val);
                  },
                  style: const TextStyle(
                    fontSize: 15.0,
                  ),
                  key: widget.key,
                  maxLines: widget.maxLines,
                  controller: widget.controller,
                  obscureText: widget.obscureText,
                  keyboardType: widget.textInputType,
                  validator: widget.validateFunction,
                  onSaved: (val) {
                    print('error => $error');
                    error = widget.validateFunction!(val) ?? '';
                    setState(() {});
                    widget.onSaved!(val!);
                  },
                  textInputAction: widget.textInputAction,
                  focusNode: widget.focusNode,
                  onFieldSubmitted: (String term) {
                    if (widget.nextFocusNode != null) {
                      widget.focusNode!.unfocus();
                      FocusScope.of(context).requestFocus(widget.nextFocusNode);
                    } else if (widget.submitAction != null) {
                      widget.submitAction!();
                    }
                  },
                  decoration: InputDecoration(
                    prefixIcon: widget.prefixIcon,
                    // suffixIcon: InkWell(
                    //   onTap: widget.locationAction,
                    //   child: Icon(
                    //     widget.suffix,
                    //     size: 15.0,
                    //   ),
                    // ),
                    // fillColor: Colors.white,
                    filled: false,
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[400],
                    ),
                    // contentPadding: EdgeInsets.symmetric(horizontal: 20.0),
                    // border: border(context),
                    disabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    border: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.transparent),
                    ),
                    errorStyle: const TextStyle(height: 0.0, fontSize: 0.0),
                  ),
                ),
              ),
            ),
          ),
        ),
        if (error != null)
          Container(
            height: 5.0,
          )
        else
          Container(),
        if (error != null)
          Text(
            error,
            style: TextStyle(
              color: Colors.red,
            ),
          )
        else
          Container(),
      ],
    );
  }
}

class DropDownTextField extends StatefulWidget {
  final List dropDownList;
  final double? width;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Function(dynamic)? onChanged;
  final String value;
  const DropDownTextField({
    Key? key,
    required this.dropDownList,
    this.width,
    required this.hintText,
    required this.controller,
    required this.onChanged,
    this.obscureText = false,
    required this.value,
  }) : super(key: key);

  @override
  _DropDownTextFieldState createState() => _DropDownTextFieldState();
}

class _DropDownTextFieldState extends State<DropDownTextField> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4.0,
      child: Container(
        height: 50,
        width: widget.width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(5),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0),
          child: Center(
            child: DropdownButton(
              icon: IconButton(
                icon: Icon(
                  CupertinoIcons.chevron_down,
                  size: 20,
                ),
                onPressed: null,
              ),
              hint: Text(widget.hintText),
              style: TextStyle(
                color: Colors.grey,
              ), // Not necessary for Option 1
              value: widget.value,
              isExpanded: true,
              onChanged: widget.onChanged,
              underline: Container(
                height: 10,
              ),
              items: widget.dropDownList.map((location) {
                return DropdownMenuItem(
                  child: Text(location),
                  value: location,
                );
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}

class IconTextField extends StatelessWidget {
  final VoidCallback? onTap;
  final double? width;
  final String hintText;
  final TextEditingController controller;
  final bool obscureText;
  final Icon? trailingIcon;
  const IconTextField({
    Key? key,
    this.onTap,
    required this.width,
    required this.hintText,
    required this.controller,
    this.obscureText = false,
    this.trailingIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 50,
        width: width ?? MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 15.0, top: 3),
          child: Center(
            child: TextField(
              style: TextStyle(
                fontSize: 14,
              ),
              controller: controller,
              obscureText: obscureText,
              decoration: InputDecoration(
                enabled: false,
                hintText: hintText,
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                    Icons.calendar_today_rounded,
                    color: Colors.grey,
                  ),
                  onPressed: () {},
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
