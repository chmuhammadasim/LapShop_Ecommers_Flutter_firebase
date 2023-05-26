import 'package:flapshopadmin/const/const.dart';
import 'package:flapshopadmin/views/widget/normal_text.dart';

Widget ourButton({title, color = purpleColor, onPress}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
      backgroundColor: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(
        12,
      ),
    ),
    onPressed: onPress,
    child: boldText(text: title, size: 16.0),
  );
}
