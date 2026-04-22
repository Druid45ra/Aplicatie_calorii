import 'package:hive/hive.dart';

import '../models/weight_entry_model.dart';

class LocalWeightDataSource {
  LocalWeightDataSource(this.box);

  final Box<dynamic> box;
  static const _key = 'weight_entries';

  Future<List<WeightEntryModel>> getEntries() async {
    final raw = box.get(_key, defaultValue: <dynamic>[]);
<<<<<<< ours

    if (raw is List) {
      return raw.whereType<Map>().map(WeightEntryModel.fromMap).toList();
    }

=======
    if (raw is List) {
      return raw.whereType<Map>().map(WeightEntryModel.fromMap).toList();
    }
>>>>>>> theirs
    return const [];
  }

  Future<void> saveEntries(List<WeightEntryModel> entries) async {
    await box.put(_key, entries.map((entry) => entry.toMap()).toList());
  }

<<<<<<< ours
  Future<void> clearEntries() async {
    await box.delete(_key);
  }
=======
  Future<void> clearEntries() => box.delete(_key);
>>>>>>> theirs
}
