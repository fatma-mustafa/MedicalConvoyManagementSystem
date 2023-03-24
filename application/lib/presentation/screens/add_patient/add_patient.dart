import 'package:application/presentation/resources/values_manager.dart';
import 'package:application/providers/marital_status.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class AddPatientScreen extends StatefulWidget {
  const AddPatientScreen({super.key});

  @override
  State<AddPatientScreen> createState() => _AddPatientScreenState();
}

class _AddPatientScreenState extends State<AddPatientScreen> {
  double screenWidth = 0.0;
  bool midScreenWidth = false;
  bool smallScreenWidth = false;
  bool largeScreenWidth = false;
  bool veryLargeScreenWidth = false;

  @override
  void initState() {
    super.initState();
    // screenWidth = MediaQuery.of(context).size.width;
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    screenWidth = MediaQuery.of(context).size.width;

    smallScreenWidth = screenWidth < 400;
    midScreenWidth = screenWidth < 800;
    largeScreenWidth = screenWidth > 800 && screenWidth < 1000;
    veryLargeScreenWidth = screenWidth > 1000;
    print(screenWidth);
  }

  @override
  Widget build(BuildContext context) {
    return ScaffoldPage.scrollable(
      children: [
        Text("Add new patient",
            style: FluentTheme.of(context).typography.title),
        const SizedBox(height: AppSize.s10),
        Text(
            "In this section you can add a new patient, you can specify if the new patient is adult or child",
            style: FluentTheme.of(context).typography.body),
        const SizedBox(height: AppSize.s10),
        Text("Personal Info",
            style: FluentTheme.of(context)
                .typography
                .title
                ?.copyWith(fontSize: 20)),
        const SizedBox(height: AppSize.s5),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Wrap(
                  // crossAxisAlignment: CrossAxisAlignment.end,
                  crossAxisAlignment: WrapCrossAlignment.start,
                  runSpacing: 10,
                  spacing: 10,
                  children: [
                    InfoLabel(
                      label: "Patient full name:",
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                            maxWidth: (screenWidth >= 1010 &&
                                        screenWidth <= 1030) ||
                                    (screenWidth >= 800 && screenWidth <= 830)
                                ? 350
                                : 400),
                        child: SizedBox(
                            width: screenWidth / 2, child: const TextBox()),
                      ),
                    ),
                    InfoLabel(label: "Sex:", child: const SexComboBox()),
                    InfoLabel(
                      label: "Age:",
                      child: const SizedBox(width: 70, child: TextBox()),
                    ),
                    const SizedBox(height: 50, child: RadioButtonsVertical()),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
                InfoLabel(
                  label: "Occupation:",
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 250),
                    child: SizedBox(
                        width: screenWidth / 3, child: const TextBox()),
                  ),
                ),
                const SizedBox(height: AppSize.s10),
                InfoLabel(
                  label: "Martial Status:",
                  child: const MartialStatus(),
                ),
                const SizedBox(height: AppSize.s10),
                InfoLabel(
                  label: "Education Level:",
                  child: const EducationLevel(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class EducationLevel extends StatelessWidget {
  const EducationLevel({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> educationLevels = [
      "Illiterate",
      "Read and write",
      "Primary",
      "Preparatory",
      "Secondary",
      "University",
      "Postgraduate"
    ];
    return RadioButtonsHorizontal(list: educationLevels);
  }
}

class MartialStatus extends StatefulWidget {
  const MartialStatus({
    super.key,
  });

  @override
  State<MartialStatus> createState() => _MartialStatusState();
}

class _MartialStatusState extends State<MartialStatus> {
  List<String> martialStatus = ["Married", "Single", "Divorced", "Widowed"];
  String selectedMartialStatus = "";

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MaritalStatus(),
      builder: (context, child) {
        String selectedStatus = context.watch<MaritalStatus>().selectedStatus;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioButtonsHorizontal(list: martialStatus, isMartialStatus: true),
            const SizedBox(height: AppSize.s10),
            if (selectedStatus.toLowerCase() != "single")
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InfoLabel(
                    label: "Number of children",
                    labelStyle: FluentTheme.of(context).typography.caption,
                    child: const SizedBox(width: 100, child: TextBox()),
                  ),
                  const SizedBox(width: AppSize.s10),
                  InfoLabel(
                    label: "Age of the youngest",
                    labelStyle: FluentTheme.of(context).typography.caption,
                    child: const SizedBox(width: 100, child: TextBox()),
                  ),
                ],
              ),
          ],
        );

        // return const SizedBox.shrink();
      },
    );
  }
}

class SexComboBox extends StatelessWidget {
  const SexComboBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    String selectedSex = "Male";
    return StatefulBuilder(builder: (context, setState) {
      return ComboBox<String>(
        value: selectedSex,
        items: ["Male", "Female"].map((sex) {
          return ComboBoxItem<String>(
            value: sex,
            child: Text(sex),
          );
        }).toList(),
        onChanged: (value) {
          selectedSex = value ?? selectedSex;
          setState(() {});
        },
      );
    });
  }
}

class RadioButtonsVertical extends StatelessWidget {
  const RadioButtonsVertical({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    int selected = 0;
    return StatefulBuilder(builder: (context, setState) {
      return Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: List.generate(2, (index) {
          return RadioButton(
            checked: index == selected,
            onChanged: (checked) {
              selected = index;
              setState(() {});
            },
            content: index == 0 ? const Text("Adult") : const Text("Child"),
          );
        }),
      );
    });
  }
}

class RadioButtonsHorizontal extends StatefulWidget {
  const RadioButtonsHorizontal({
    super.key,
    required this.list,
    this.isMartialStatus = false,
  });
  final List<String> list;
  final bool isMartialStatus;

  @override
  State<RadioButtonsHorizontal> createState() => _RadioButtonsHorizontalState();
}

class _RadioButtonsHorizontalState extends State<RadioButtonsHorizontal> {
  int selected = 0;

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 20,
      runSpacing: 10,
      children: List.generate(widget.list.length, (index) {
        return RadioButton(
          checked: index == selected,
          onChanged: (checked) {
            selected = index;
            if (widget.isMartialStatus) {
              context.read<MaritalStatus>().selectedStatus = widget.list[index];
            }
            setState(() {});
          },
          content: Text(widget.list[index]),
        );
      }),
    );
  }
}
