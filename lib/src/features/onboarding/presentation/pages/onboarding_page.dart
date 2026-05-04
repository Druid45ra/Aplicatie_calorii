import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/widgets/app_scaffold.dart';

import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../domain/entities/user_profile.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

  BiologicalSex _sex = BiologicalSex.other;
  ActivityLevel _activity = ActivityLevel.moderate;
  GoalType _goal = GoalType.maintain;


  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Welcome',
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text('Build your nutrition baseline', style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            DropdownButtonFormField<BiologicalSex>(
              value: _sex,
              decoration: const InputDecoration(labelText: 'Sex'),
              items: BiologicalSex.values
                  .map((value) => DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) => setState(() => _sex = value ?? BiologicalSex.other),
            ),
            const SizedBox(height: 16),
            _numberField(_ageController, 'Age'),
            const SizedBox(height: 16),
            _numberField(_heightController, 'Height (cm)'),
            const SizedBox(height: 16),
            _numberField(_weightController, 'Weight (kg)'),
            const SizedBox(height: 16),
            DropdownButtonFormField<ActivityLevel>(
              value: _activity,
              decoration: const InputDecoration(labelText: 'Activity level'),
              items: ActivityLevel.values
                  .map((value) => DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) => setState(() => _activity = value ?? ActivityLevel.moderate),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GoalType>(
              value: _goal,
              decoration: const InputDecoration(labelText: 'Goal'),
              items: GoalType.values
                  .map((value) => DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) => setState(() => _goal = value ?? GoalType.maintain),
            ),
            const SizedBox(height: 24),
            FilledButton(
              onPressed: _submit,
              child: const Text('Save and continue'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _numberField(TextEditingController controller, String label) {

    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,

    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final age = int.parse(_ageController.text);
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);
    final calories = _estimateCalories(age: age, heightCm: height, weightKg: weight);
    final profile = UserProfile(
      sex: _sex,
      age: age,
      heightCm: height,
      weightKg: weight,
      goal: _goal,
      activityLevel: _activity,
      dailyCalorieTarget: calories,
    );
    await ref.read(profileControllerProvider.notifier).save(profile);

    if (mounted) {
      context.go('/dashboard');
    }
  }

  int _estimateCalories({required int age, required double heightCm, required double weightKg}) {

    final base = switch (_sex) {
      BiologicalSex.male => 10 * weightKg + 6.25 * heightCm - 5 * age + 5,
      BiologicalSex.female => 10 * weightKg + 6.25 * heightCm - 5 * age - 161,
      BiologicalSex.other => 10 * weightKg + 6.25 * heightCm - 5 * age - 78,
    };

    final factor = switch (_activity) {
      ActivityLevel.sedentary => 1.2,
      ActivityLevel.light => 1.375,
      ActivityLevel.moderate => 1.55,
      ActivityLevel.active => 1.725,
      ActivityLevel.athlete => 1.9,
    };

    final adjusted = switch (_goal) {
      GoalType.loseWeight => base * factor - 350,
      GoalType.maintain => base * factor,
      GoalType.gainWeight => base * factor + 250,
    };

    return adjusted.round();
  }
}
