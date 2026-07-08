import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/meal_entry.dart';
import '../controllers/meal_form_controller.dart';

/// Optimized meal form using Riverpod for state management
/// This replaces the old StatefulWidget approach with reactive state management
class MealFormSheet extends ConsumerWidget {
  const MealFormSheet({
    required this.onSave,
    this.initial,
    super.key,
  });

  final MealEntry? initial;
  final void Function(MealEntry entry) onSave;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formState = ref.watch(mealFormProvider);
    final formNotifier = ref.read(mealFormProvider.notifier);

    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              initial == null ? 'Add meal' : 'Edit meal',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            
            // Meal name field
            _MealNameField(
              value: formState.name,
              error: formState.errors['name'],
              onChanged: formNotifier.updateName,
            ),
            const SizedBox(height: 12),

            // Meal type dropdown
            _MealTypeDropdown(
              value: formState.mealType,
              onChanged: formNotifier.updateMealType,
            ),
            const SizedBox(height: 12),

            // Calories field
            _NumericField(
              label: 'Calories',
              value: formState.calories.toString(),
              error: formState.errors['calories'],
              keyboardType: TextInputType.number,
              min: 0,
              max: 10000,
              allowDecimal: false,
              onChanged: (value) {
                final parsed = int.tryParse(value) ?? 0;
                formNotifier.updateCalories(parsed);
              },
            ),
            const SizedBox(height: 12),

            // Macros row
            Row(
              children: [
                Expanded(
                  child: _NumericField(
                    label: 'Protein (g)',
                    value: formState.protein.toString(),
                    error: formState.errors['protein'],
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 500,
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0;
                      formNotifier.updateProtein(parsed);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumericField(
                    label: 'Carbs (g)',
                    value: formState.carbs.toString(),
                    error: formState.errors['carbs'],
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 1000,
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0;
                      formNotifier.updateCarbs(parsed);
                    },
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _NumericField(
                    label: 'Fat (g)',
                    value: formState.fat.toString(),
                    error: formState.errors['fat'],
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 500,
                    onChanged: (value) {
                      final parsed = double.tryParse(value) ?? 0;
                      formNotifier.updateFat(parsed);
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Notes field
            _NotesField(
              value: formState.notes,
              onChanged: formNotifier.updateNotes,
            ),
            const SizedBox(height: 16),

            // Save button
            FilledButton(
              onPressed: () => _handleSave(context, formNotifier, formState),
              child: const Text('Save meal'),
            ),
          ],
        ),
      ),
    );
  }

  void _handleSave(
    BuildContext context,
    MealFormNotifier notifier,
    MealFormState state,
  ) {
    final errors = notifier.validate();
    if (errors.isNotEmpty) return;

    onSave(
      MealEntry(
        id: initial?.id ?? '',
        name: state.name.trim(),
        calories: state.calories,
        protein: state.protein,
        carbs: state.carbs,
        fat: state.fat,
        date: initial?.date ?? DateTime.now(),
        mealType: state.mealType,
        notes: state.notes.trim(),
      ),
    );

    Navigator.of(context).pop();
  }
}

/// Reusable meal name input field
class _MealNameField extends StatelessWidget {
  const _MealNameField({
    required this.value,
    required this.onChanged,
    this.error,
  });

  final String value;
  final String? error;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: 'Meal name',
        errorText: error,
      ),
    );
  }
}

/// Reusable meal type dropdown
class _MealTypeDropdown extends StatelessWidget {
  const _MealTypeDropdown({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  static const mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(labelText: 'Meal type'),
      items: mealTypes
          .map((type) => DropdownMenuItem(value: type, child: Text(type)))
          .toList(),
      onChanged: (value) => onChanged(value ?? 'Breakfast'),
    );
  }
}

/// Reusable numeric input field with validation
class _NumericField extends StatelessWidget {
  const _NumericField({
    required this.label,
    required this.value,
    required this.onChanged,
    this.error,
    this.keyboardType = TextInputType.number,
    this.min = 0,
    this.max = 10000,
    this.allowDecimal = true,
  });

  final String label;
  final String value;
  final String? error;
  final ValueChanged<String> onChanged;
  final TextInputType keyboardType;
  final int min;
  final int max;
  final bool allowDecimal;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        errorText: error,
      ),
    );
  }
}

/// Reusable notes input field
class _NotesField extends StatelessWidget {
  const _NotesField({
    required this.value,
    required this.onChanged,
  });

  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      maxLines: 3,
      decoration: const InputDecoration(
        labelText: 'Notes',
        hintText: 'Add any additional notes...',
      ),
    );
  }
}
