import 'package:hive/hive.dart';

import '../models/weight_entry_model.dart';

class LocalWeightDataSource {
  LocalWeightDataSource(this.box);

  final Box<dynamic> box;
  static const _key = 'weight_entries';

  Future<List<WeightEntryModel>> getEntries() async {
    final raw = box.get(_key, defaultValue: <dynamic>[]);
    if (raw is List) {
      return raw.whereType<Map>().map(WeightEntryModel.fromMap).toList();
    }

    return const [];
  }

  Future<void> saveEntries(List<WeightEntryModel> entries) async {
    await box.put(_key, entries.map((entry) => entry.toMap()).toList());
  }

  Future<void> clearEntries() => box.delete(_key);

}
