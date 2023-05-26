import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';

Widget customTextField({label, hint, controller, isDescription = false}) {
  return TextFormField(
    controller: controller,
    style: const TextStyle(color: white),
    maxLines: isDescription ? 4 : 1,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: white,
        ),
      ),
      hintText: hint,
      hintStyle: const TextStyle(color: lightGrey),
    ),
  );
}
