import 'package:flutter/material.dart'
    show
        BuildContext,
        Card,
        NeverScrollableScrollPhysics,
        StatelessWidget,
        Step,
        StepState,
        Stepper,
        StepperType,
        Widget;
import 'package:fluent_ui/fluent_ui.dart' as fluent_ui
    show Text, Container, Wrap;

class StepperSection extends StatelessWidget {
  const StepperSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      borderOnForeground: false,
      elevation: 0.0,
      semanticContainer: false,
      child: Stepper(
        elevation: 0.0,
        physics: const NeverScrollableScrollPhysics(),
        controlsBuilder: (context, details) {
          return fluent_ui.Container();
        },
        type: StepperType.horizontal,
        steps: getSteps(),
      ),
    );
  }

  List<Step> getSteps() => [
        Step(
          title: const fluent_ui.Text("Personal Info"),
          content: fluent_ui.Container(),
          subtitle: const fluent_ui.Text("Stup"),
          isActive: true,
          state: StepState.disabled,
          // label: const fluent_ui.Text("Stup"),
        ),
        Step(
          title: const fluent_ui.Text("Habits of Medical importance"),
          content: fluent_ui.Container(),
        ),
        Step(
          title: const fluent_ui.Text("History of Present Illness"),
          content: fluent_ui.Container(),
        ),
        Step(
          title: const fluent_ui.Text("Past History"),
          content: fluent_ui.Container(),
        ),
      ];
}
