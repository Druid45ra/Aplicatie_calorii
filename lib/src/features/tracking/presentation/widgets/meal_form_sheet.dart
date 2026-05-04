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
    _caloriesController = TextEditingController(text: initial?.calories.toString() ?? '');
    _proteinController = TextEditingController(text: initial?.protein.toString() ?? '');
    _carbsController = TextEditingController(text: initial?.carbs.toString() ?? '');
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
              Text(widget.initial == null ? 'Add meal' : 'Edit meal', style: Theme.of(context).textTheme.headlineSmall),

              const SizedBox(height: 16),
              _field(_nameController, 'Meal name'),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _mealType,
                decoration: const InputDecoration(labelText: 'Meal type'),
                items: const ['Breakfast', 'Lunch', 'Dinner', 'Snack']
                    .map((value) => DropdownMenuItem(value: value, child: Text(value)))
                    .toList(),
                onChanged: (value) => setState(() => _mealType = value ?? 'Breakfast'),
              ),
              const SizedBox(height: 12),
              _field(_caloriesController, 'Calories', keyboardType: TextInputType.number),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: _field(_proteinController, 'Protein', keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: _field(_carbsController, 'Carbs', keyboardType: TextInputType.number)),
                const SizedBox(width: 12),
                Expanded(child: _field(_fatController, 'Fat', keyboardType: TextInputType.number)),
              ]),
              const SizedBox(height: 12),
              _field(_notesController, 'Notes', maxLines: 3, requiredField: false),
              const SizedBox(height: 16),
              FilledButton(onPressed: _save, child: const Text('Save meal')),
            ],
          ),
        ),
      ),
    );
  }

  Widget _field(TextEditingController controller, String label, {TextInputType? keyboardType, int maxLines = 1, bool requiredField = true}) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(labelText: label),
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: (value) {
        if (!requiredField) {
          return null;
        }
        return (value == null || value.trim().isEmpty) ? 'Required' : null;

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
        calories: int.parse(_caloriesController.text),
        protein: double.parse(_proteinController.text),
        carbs: double.parse(_carbsController.text),
        fat: double.parse(_fatController.text),
        date: widget.initial?.date ?? DateTime.now(),
        mealType: _mealType,
        notes: _notesController.text.trim(),
      ),
    );

    Navigator.of(context).pop();
  }
}
