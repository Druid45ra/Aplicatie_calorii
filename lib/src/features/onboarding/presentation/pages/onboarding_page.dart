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
  void initState() {
    super.initState();
    Future.microtask(_loadExistingProfile);
  }

  @override
  void dispose() {
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    super.dispose();
  }

  Future<void> _loadExistingProfile() async {
    final profile = await ref.read(profileControllerProvider.future);
    if (!mounted || profile == null) {
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
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Welcome',
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Text('Build your nutrition baseline',
                style: Theme.of(context).textTheme.headlineSmall),
            const SizedBox(height: 20),
            DropdownButtonFormField<BiologicalSex>(
              key: ValueKey(_sex),
              initialValue: _sex,
              decoration: const InputDecoration(labelText: 'Sex'),
              items: BiologicalSex.values
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => _sex = value ?? BiologicalSex.other),
            ),
            const SizedBox(height: 16),
            _numberField(
              _ageController,
              'Age',
              min: 13,
              max: 120,
              allowDecimal: false,
            ),
            const SizedBox(height: 16),
            _numberField(_heightController, 'Height (cm)', min: 80, max: 250),
            const SizedBox(height: 16),
            _numberField(_weightController, 'Weight (kg)', min: 25, max: 350),
            const SizedBox(height: 16),
            DropdownButtonFormField<ActivityLevel>(
              key: ValueKey(_activity),
              initialValue: _activity,
              decoration: const InputDecoration(labelText: 'Activity level'),
              items: ActivityLevel.values
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => _activity = value ?? ActivityLevel.moderate),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<GoalType>(
              key: ValueKey(_goal),
              initialValue: _goal,
              decoration: const InputDecoration(labelText: 'Goal'),
              items: GoalType.values
                  .map((value) =>
                      DropdownMenuItem(value: value, child: Text(value.name)))
                  .toList(),
              onChanged: (value) =>
                  setState(() => _goal = value ?? GoalType.maintain),
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

  Widget _numberField(
    TextEditingController controller,
    String label, {
    required num min,
    required num max,
    bool allowDecimal = true,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: allowDecimal),
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        final parsed = _parseNumber(value);
        if (parsed == null) {
          return 'Enter a valid number';
        }
        if (!allowDecimal && parsed % 1 != 0) {
          return 'Enter a whole number';
        }
        if (parsed < min || parsed > max) {
          return 'Enter a value between $min and $max';
        }
        return null;
      },
    );
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }
    final age = _parseNumber(_ageController.text)!.toInt();
    final height = _parseNumber(_heightController.text)!;
    final weight = _parseNumber(_weightController.text)!;
    final calories =
        _estimateCalories(age: age, heightCm: height, weightKg: weight);
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

  int _estimateCalories(
      {required int age, required double heightCm, required double weightKg}) {
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

  double? _parseNumber(String? value) {
    final normalized = value?.trim().replaceAll(',', '.');
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return double.tryParse(normalized);
  }
}
