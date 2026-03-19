import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

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
    final profileState = ref.watch(profileControllerProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Onboarding')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Text(
                'Setează profilul tău',
                style: Theme.of(context).textTheme.headlineSmall,
              ),
              const SizedBox(height: 20),
              DropdownButtonFormField<BiologicalSex>(
                initialValue: _sex,
                decoration: const InputDecoration(labelText: 'Sex'),
                items: BiologicalSex.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _sex = value ?? BiologicalSex.other;
                  });
                },
              ),
              const SizedBox(height: 16),
              _numberField(
                controller: _ageController,
                label: 'Age',
                isInteger: true,
              ),
              const SizedBox(height: 16),
              _numberField(controller: _heightController, label: 'Height (cm)'),
              const SizedBox(height: 16),
              _numberField(controller: _weightController, label: 'Weight (kg)'),
              const SizedBox(height: 16),
              DropdownButtonFormField<ActivityLevel>(
                initialValue: _activity,
                decoration: const InputDecoration(labelText: 'Activity level'),
                items: ActivityLevel.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _activity = value ?? ActivityLevel.moderate;
                  });
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<GoalType>(
                initialValue: _goal,
                decoration: const InputDecoration(labelText: 'Goal'),
                items: GoalType.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.name),
                      ),
                    )
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _goal = value ?? GoalType.maintain;
                  });
                },
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: profileState.isLoading ? null : _submit,
                child: profileState.isLoading
                    ? const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Text('Save profile'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _numberField({
    required TextEditingController controller,
    required String label,
    bool isInteger = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        final text = value?.trim() ?? '';

        if (text.isEmpty) {
          return 'Required';
        }

        if (isInteger) {
          final parsed = int.tryParse(text);
          if (parsed == null || parsed <= 0) {
            return 'Invalid value';
          }
        } else {
          final parsed = double.tryParse(text);
          if (parsed == null || parsed <= 0) {
            return 'Invalid value';
          }
        }

        return null;
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final age = int.tryParse(_ageController.text.trim());
    final height = double.tryParse(_heightController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (age == null || height == null || weight == null) {
      return;
    }

    final profile = UserProfile(
      sex: _sex,
      age: age,
      heightCm: height,
      weightKg: weight,
      goal: _goal,
      activityLevel: _activity,
      dailyCalorieTarget: _estimateCalories(
        age: age,
        heightCm: height,
        weightKg: weight,
      ),
    );

    await ref.read(profileControllerProvider.notifier).save(profile);

    if (mounted) {
      context.go('/dashboard');
    }
  }

  int _estimateCalories({
    required int age,
    required double heightCm,
    required double weightKg,
  }) {
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
