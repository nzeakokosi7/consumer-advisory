part of 'bio_password_field.dart';

class _SinglePasswordCheck extends StatelessWidget {
  final String text;
  final bool isEnable;

  const _SinglePasswordCheck({
    required this.text,
    required this.isEnable,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Checkbox(
          activeColor: AppColors.titleColor,
          value: isEnable,
          onChanged: (v) {},
          shape: const CircleBorder(),
        ),
        Text(
          text,
          style: Theme.of(context).textTheme.labelSmall?.copyWith(
            fontSize: 11,
            fontWeight: FontWeight.w500,
            color: isEnable ? AppColors.titleColor : Colors.grey,
          ),
        ),
      ],
    );
  }
}
