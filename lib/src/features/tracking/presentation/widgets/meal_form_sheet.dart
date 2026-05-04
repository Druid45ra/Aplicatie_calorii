import 'package:flutter/material.dart';

import '../../domain/entities/meal_entry.dart';

class MealFormSheet extends StatefulWidget {
  const MealFormSheet({required this.onSave, super.key, this.initial});

  final MealEntry? initial;
  final void Function(MealEntry entry) onSave;

  @override
  State<MealFormSheet> createState() => _MealFormSheetState();
}

class _MealFormSheetState extends State<MealFormSheet> {
  final _formKey = GlobalKey<FormState>();

  late final TextEditingController _nameController;
  late final TextEditingController _caloriesController;
  late final TextEditingController _proteinController;
  late final TextEditingController _carbsController;
  late final TextEditingController _fatController;
  late final TextEditingController _notesController;

  String _mealType = 'Breakfast';

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _nameController = TextEditingController(text: initial?.name ?? '');
    _caloriesController =
        TextEditingController(text: initial?.calories.toString() ?? '');
    _proteinController =
        TextEditingController(text: initial?.protein.toString() ?? '');
    _carbsController =
        TextEditingController(text: initial?.carbs.toString() ?? '');
    _fatController = TextEditingController(text: initial?.fat.toString() ?? '');
    _notesController = TextEditingController(text: initial?.notes ?? '');
    _mealType = initial?.mealType ?? 'Breakfast';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 16,
      ),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(widget.initial == null ? 'Add meal' : 'Edit meal',
                  style: Theme.of(context).textTheme.headlineSmall),
              const SizedBox(height: 16),
              _field(_nameController, 'Meal name'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                initialValue: _mealType,
                decoration: const InputDecoration(labelText: 'Meal type'),
                items: const ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                    .map((value) =>
                        DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) =>
                    setState(() => _mealType = value ?? 'Breakfast'),
              ),
              const SizedBox(height: 12),
              _field(
                _caloriesController,
                'Calories',
                keyboardType: TextInputType.number,
                min: 0,
                max: 10000,
                allowDecimal: false,
              ),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(
                  child: _field(
                    _proteinController,
                    'Protein',
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 500,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    _carbsController,
                    'Carbs',
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 1000,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _field(
                    _fatController,
                    'Fat',
                    keyboardType: TextInputType.number,
                    min: 0,
                    max: 500,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              _field(_notesController, 'Notes',
                  maxLines: 3, requiredField: false),
              const SizedBox(height: 16),
              FilledButton(onPressed: _save, child: const Text('Save meal')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    TextInputType? keyboardType,
    int maxLines = 1,
    bool requiredField = true,
    num? min,
    num? max,
    bool allowDecimal = true,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (!requiredField) {
          return null;
        }
        if (value == null || value.trim().isEmpty) {
          return 'Required';
        }
        if (min == null || max == null) {
          return null;
        }
        final parsed = _parseNumber(value);
        if (parsed == null) {
          return 'Enter a valid number';
        }
        if (!allowDecimal && parsed % 1 != 0) {
          return 'Enter a whole number';
        }
        if (parsed < min || parsed > max) {
          return 'Enter $min-$max';
        }
        return null;
      },
    );
  }

  void _save() {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    widget.onSave(
      MealEntry(
        id: widget.initial?.id ?? '',
        name: _nameController.text.trim(),
        calories: _parseNumber(_caloriesController.text)!.toInt(),
        protein: _parseNumber(_proteinController.text)!,
        carbs: _parseNumber(_carbsController.text)!,
        fat: _parseNumber(_fatController.text)!,
        date: widget.initial?.date ?? DateTime.now(),
        mealType: _mealType,
        notes: _notesController.text.trim(),
      ),
    );

    Navigator.of(context).pop();
  }

  double? _parseNumber(String? value) {
    final normalized = value?.trim().replaceAll(',', '.');
    if (normalized == null || normalized.isEmpty) {
      return null;
    }
    return double.tryParse(normalized);
  }
}
