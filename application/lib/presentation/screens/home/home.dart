import 'package:application/main.dart';
import 'package:application/presentation/resources/values_manager.dart';
import 'package:fluent_ui/fluent_ui.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppPadding.p10),
      child: SizedBox(
        width: double.infinity,
        child: Column(
          children: [
            Row(
              children: [
                Button(
                  onPressed: () {
                    router.pushNamed('clinics');
                  },
                  child: Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(FluentIcons.add, size: 10),
                      const SizedBox(width: 4),
                      Text(
                        "Add patient",
                        style: FluentTheme.of(context).typography.caption,
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
