import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

<<<<<<< ours
=======
import '../../../../core/widgets/app_scaffold.dart';
>>>>>>> theirs
import '../../../profile/presentation/controllers/profile_controller.dart';
import '../../domain/entities/user_profile.dart';

class OnboardingPage extends ConsumerStatefulWidget {
  const OnboardingPage({super.key});

  @override
  ConsumerState<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends ConsumerState<OnboardingPage> {
  final _formKey = GlobalKey<FormState>();
<<<<<<< ours

  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();

=======
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
>>>>>>> theirs
  BiologicalSex _sex = BiologicalSex.other;
  ActivityLevel _activity = ActivityLevel.moderate;
  GoalType _goal = GoalType.maintain;

<<<<<<< ours
  bool _didPrefill = false;

=======
>>>>>>> theirs
  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
<<<<<<< ours
    final profileState = ref.watch(profileControllerProvider);

    profileState.whenData((profile) {
      if (profile != null && !_didPrefill) {
        _didPrefill = true;

        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) {
            return;
          }

          setState(() {
            _sex = profile.sex;
            _activity = profile.activityLevel;
            _goal = profile.goal;
            _ageController.text = profile.age.toString();
            _heightController.text = profile.heightCm.toString();
            _weightController.text = profile.weightKg.toString();
          });
        });
      }
    });

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
=======
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
>>>>>>> theirs
        ),
      ),
    );
  }

<<<<<<< ours
  Widget _numberField({
    required TextEditingController controller,
    required String label,
    bool isInteger = false,
  }) {
=======
  Widget _numberField(TextEditingController controller, String label) {
>>>>>>> theirs
    return TextFormField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(decimal: true),
      decoration: InputDecoration(labelText: label),
<<<<<<< ours
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
=======
      validator: (value) => (value == null || value.isEmpty) ? 'Required' : null,
>>>>>>> theirs
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
<<<<<<< ours

    final age = int.tryParse(_ageController.text.trim());
    final height = double.tryParse(_heightController.text.trim());
    final weight = double.tryParse(_weightController.text.trim());

    if (age == null || height == null || weight == null) {
      return;
    }

=======
    final age = int.parse(_ageController.text);
    final height = double.parse(_heightController.text);
    final weight = double.parse(_weightController.text);
    final calories = _estimateCalories(age: age, heightCm: height, weightKg: weight);
>>>>>>> theirs
    final profile = UserProfile(
      sex: _sex,
      age: age,
      heightCm: height,
      weightKg: weight,
      goal: _goal,
      activityLevel: _activity,
<<<<<<< ours
      dailyCalorieTarget: _estimateCalories(
        age: age,
        heightCm: height,
        weightKg: weight,
      ),
    );

    await ref.read(profileControllerProvider.notifier).save(profile);

=======
      dailyCalorieTarget: calories,
    );
    await ref.read(profileControllerProvider.notifier).save(profile);
>>>>>>> theirs
    if (mounted) {
      context.go('/dashboard');
    }
  }

<<<<<<< ours
  int _estimateCalories({
    required int age,
    required double heightCm,
    required double weightKg,
  }) {
=======
  int _estimateCalories({required int age, required double heightCm, required double weightKg}) {
>>>>>>> theirs
    final base = switch (_sex) {
      BiologicalSex.male => 10 * weightKg + 6.25 * heightCm - 5 * age + 5,
      BiologicalSex.female => 10 * weightKg + 6.25 * heightCm - 5 * age - 161,
      BiologicalSex.other => 10 * weightKg + 6.25 * heightCm - 5 * age - 78,
    };
<<<<<<< ours

=======
>>>>>>> theirs
    final factor = switch (_activity) {
      ActivityLevel.sedentary => 1.2,
      ActivityLevel.light => 1.375,
      ActivityLevel.moderate => 1.55,
      ActivityLevel.active => 1.725,
      ActivityLevel.athlete => 1.9,
    };
<<<<<<< ours

=======
>>>>>>> theirs
    final adjusted = switch (_goal) {
      GoalType.loseWeight => base * factor - 350,
      GoalType.maintain => base * factor,
      GoalType.gainWeight => base * factor + 250,
    };
<<<<<<< ours

=======
>>>>>>> theirs
    return adjusted.round();
  }
}
