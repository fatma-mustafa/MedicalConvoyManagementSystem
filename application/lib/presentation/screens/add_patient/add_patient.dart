import 'package:application/presentation/resources/color_manager.dart';
import 'package:application/presentation/resources/values_manager.dart';
import 'package:application/providers/marital_status.dart';
import 'package:fluent_ui/fluent_ui.dart';
import 'package:provider/provider.dart';

class AddPatientScreen extends StatelessWidget {
  const AddPatientScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppPadding.p25),
          child: ScaffoldPage.scrollable(
            children: [
              Text("Add new patient",
                  style: FluentTheme.of(context).typography.title),
              const SizedBox(height: AppSize.s10),
              Text(
                  "In this section you can add a new patient, you can specify if the new patient is adult or child",
                  style: FluentTheme.of(context).typography.body),
              const SizedBox(height: AppSize.s10),
              // TODO: Add Stepper
              // SizedBox(
              //     height: screenHeight / 7.3,
              //     // width: 100,
              //     child: const StepperSection()),
              const SizedBox(height: AppSize.s10),
              const PersonalInfo(),
              const SizedBox(height: AppSize.s10),

              const HabitsOfMImportance(),
            ],
          ),
        ),
        const Align(
          alignment: Alignment.bottomCenter,
          child: StackedButton(),
        ),
      ],
    );
  }
}

class StackedButton extends StatelessWidget {
  const StackedButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppPadding.p8),
      child: SizedBox(
        width: 160,
        height: 35,
        child: Card(
          padding: const EdgeInsets.symmetric(horizontal: AppPadding.p6),
          backgroundColor: ColorManager.secondary,
          child: Row(
            children: [
              SizedBox(
                width: 90,
                child: Center(
                  child: FilledButton(
                    onPressed: () {},
                    style: const ButtonStyle(),
                    child: Text(
                      "Save & Continue",
                      style:
                          FluentTheme.of(context).typography.caption?.copyWith(
                                fontSize: 9,
                              ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HabitsOfMImportance extends StatelessWidget {
  const HabitsOfMImportance({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Habits of Medical Importance",
          style:
              FluentTheme.of(context).typography.title?.copyWith(fontSize: 20),
        ),
        const SizedBox(height: AppSize.s5),
        Card(
          child: SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                BinarySmokingStatus(),
                SizedBox(height: AppSize.s10),
                SmokingCessation(),
                SizedBox(height: AppSize.s10),

                Menstruation(),
                SizedBox(height: AppSize.s10),

                Contraception(),
                // InfoLabel(
                //   label: "Education Level:",
                //   child: const EducationLevel(),
                // ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class Contraception extends StatefulWidget {
  const Contraception({super.key});

  @override
  State<Contraception> createState() => _ContraceptionState();
}

class _ContraceptionState extends State<Contraception> {
  int selected = 1;

  String selectedStatus = "No";
  List<String> status = ["Yes", "No"];
  String selectedMethod = "IUD";
  List<String> contraceptionMethods = ["IUD", "Implant", "COC", "Other"];

  @override
  Widget build(BuildContext context) {
    return InfoLabel(
      label: "Contraception:",
      // isHeader: false,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 20,
        children: [
          ...List.generate(status.length, (index) {
            return RadioButton(
              checked: index == selected,
              onChanged: (checked) {
                selected = index;
                selectedStatus = status[index];
                setState(() {});
              },
              content: SizedBox(
                width: 110,
                child: Text(status[index]),
              ),
            );
          }),
          if (selectedStatus.toLowerCase() != "no") ...{
            InfoLabel(
              label: "Method",
              child: SizedBox(
                width: 120,
                child: ComboBox<String>(
                  value: selectedMethod,
                  items: contraceptionMethods.map((item) {
                    return ComboBoxItem<String>(
                      value: item,
                      child: Text(item),
                    );
                  }).toList(),
                  onChanged: (value) {
                    selectedMethod = value ?? selectedMethod;
                    setState(() {});
                  },
                ),
              ),
            ),
            if (selectedMethod == "Other")
              InfoLabel(
                label: "Specify",
                child: const SizedBox(
                  width: 100,
                  child: TextBox(),
                ),
              ),
          },
        ],
      ),
    );
  }
}

class Menstruation extends StatelessWidget {
  const Menstruation({super.key});

  @override
  Widget build(BuildContext context) {
    List<String> menstruations = ["Regular", "Irregular", "Menopause"];
    return Wrap(
      spacing: 10,
      runSpacing: 20,
      children: [
        InfoLabel(
          label: "Menstruation:",
          child: RadioButtonsHorizontal(list: menstruations),
        ),
        InfoLabel(
          label: "Gravid Number",
          child: const SizedBox(
            width: 100,
            child: TextBox(),
          ),
        ),
        InfoLabel(
          label: "Abortion Number",
          child: const SizedBox(
            width: 100,
            child: TextBox(),
          ),
        ),
      ],
    );
  }
}

class SmokingCessation extends StatefulWidget {
  const SmokingCessation({super.key});

  @override
  State<SmokingCessation> createState() => _SmokingCessationState();
}

class _SmokingCessationState extends State<SmokingCessation> {
  int selected = 1;
  String selectedSmokingStatus = "No";

  @override
  Widget build(BuildContext context) {
    List<String> smokingStatus = ["Yes", "No"];
    return InfoLabel(
      label: "Smoking Cessation:",
      // isHeader: false,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          ...List.generate(smokingStatus.length, (index) {
            return RadioButton(
              checked: index == selected,
              onChanged: (checked) {
                selected = index;
                selectedSmokingStatus = smokingStatus[index];
                setState(() {});
              },
              content: SizedBox(
                width: 110,
                child: Text(smokingStatus[index]),
              ),
            );
          }),
          if (selectedSmokingStatus.toLowerCase() != "no") ...{
            InfoLabel(
              label: "Duration",
              child: const SizedBox(
                width: 120,
                child: TextBox(),
              ),
            ),
          },
        ],
      ),
    );
  }
}

class BinarySmokingStatus extends StatefulWidget {
  const BinarySmokingStatus({super.key});

  @override
  State<BinarySmokingStatus> createState() => _BinarySmokingStatusState();
}

class _BinarySmokingStatusState extends State<BinarySmokingStatus> {
  int selected = 1;
  String selectedSmokingStatus = "No";

  @override
  Widget build(BuildContext context) {
    List<String> smokingStatus = ["Yes", "No"];
    return InfoLabel(
      label: "Smoking:",
      // isHeader: false,
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        runSpacing: 10,
        children: [
          ...List.generate(smokingStatus.length, (index) {
            return RadioButton(
              checked: index == selected,
              onChanged: (checked) {
                selected = index;
                selectedSmokingStatus = smokingStatus[index];
                setState(() {});
              },
              content: SizedBox(
                width: 110,
                child: Text(smokingStatus[index]),
              ),
            );
          }),
          InfoLabel(
            label: "Other Habits",
            child: const SizedBox(
              width: 140,
              child: TextBox(),
            ),
          ),
          if (selectedSmokingStatus.toLowerCase() != "no") ...{
            Row(
              children: [
                InfoLabel(
                  label: "Rate",
                  child: Row(
                    children: const [
                      SizedBox(width: 50, child: TextBox()),
                      SizedBox(width: AppSize.s10),
                      Text("/ Day"),
                    ],
                  ),
                ),
                const SizedBox(width: AppSize.s10),
                InfoLabel(
                  label: "Type",
                  child: const SizedBox(
                    width: 120,
                    child: TextBox(),
                  ),
                ),
              ],
            ),
          },
        ],
      ),
    );
  }
}

class PersonalInfo extends StatelessWidget {
  const PersonalInfo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Personal Info",
              style: FluentTheme.of(context)
                  .typography
                  .title
                  ?.copyWith(fontSize: 20),
            ),
            FilledButton(
              onPressed: () {},
              style: const ButtonStyle(),
              child: Text(
                "Save & Continue",
                style: FluentTheme.of(context).typography.caption?.copyWith(
                      fontSize: 9,
                    ),
              ),
            ),
          ],
        ),
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
                        constraints: const BoxConstraints(minWidth: 250),
                        child: LayoutBuilder(builder: (context, constraints) {
                          return SizedBox(
                            width: constraints.maxWidth < 400
                                ? constraints.maxWidth
                                : constraints.maxWidth > 800
                                    ? constraints.maxWidth - 400
                                    : constraints.maxWidth,
                            child: const TextBox(),
                          );
                        }),
                      ),
                    ),
                    const Sex(),
                    InfoLabel(
                      label: "Age:",
                      child: LayoutBuilder(builder: (context, constraints) {
                        return const SizedBox(width: 70, child: TextBox());
                      }),
                    ),
                    const SizedBox(height: 50, child: RadioButtonsVertical()),
                  ],
                ),
                const SizedBox(height: AppSize.s10),
                InfoLabel(
                  label: "Occupation:",
                  child: ConstrainedBox(
                    constraints: const BoxConstraints(minWidth: 250),
                    child: LayoutBuilder(builder: (context, constraints) {
                      return SizedBox(
                        width: constraints.maxWidth < 400
                            ? constraints.maxWidth
                            : constraints.maxWidth > 800
                                ? constraints.maxWidth - 400
                                : constraints.maxWidth,
                        child: const TextBox(),
                      );
                    }),
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

class Sex extends StatelessWidget {
  const Sex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<String> genders = ["Male", "Female"];
    return InfoLabel(label: "Sex:", child: CustomComboBox(list: genders));
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
                    child: const SizedBox(
                      width: 100,
                      child: TextBox(),
                    ),
                  ),
                  const SizedBox(width: AppSize.s10),
                  InfoLabel(
                    label: "Age of the youngest",
                    labelStyle: FluentTheme.of(context).typography.caption,
                    child: const SizedBox(
                      width: 100,
                      child: TextBox(),
                    ),
                  ),
                ],
              ),
          ],
        );
      },
    );
  }
}

class CustomComboBox extends StatelessWidget {
  const CustomComboBox({
    super.key,
    required this.list,
  });
  final List<String> list;

  @override
  Widget build(BuildContext context) {
    String selectedChoice = list[0];
    return StatefulBuilder(builder: (context, setState) {
      return ComboBox<String>(
        value: selectedChoice,
        items: list.map((item) {
          return ComboBoxItem<String>(
            value: item,
            child: Text(item),
          );
        }).toList(),
        onChanged: (value) {
          selectedChoice = value ?? selectedChoice;
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
          content: SizedBox(width: 110, child: Text(widget.list[index])),
        );
      }),
    );
  }
}
